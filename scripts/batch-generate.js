#!/usr/bin/env node

/**
 * Batch PDF Generation Script
 * Process multiple JSON data files at once
 *
 * Usage:
 *   node scripts/batch-generate.js <directory>
 *   node scripts/batch-generate.js data/*.json
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');
const { glob } = require('glob');

const args = process.argv.slice(2);

if (args.length === 0) {
  console.error('Usage: node scripts/batch-generate.js <directory|pattern>');
  console.error('Examples:');
  console.error('  node scripts/batch-generate.js data/');
  console.error('  node scripts/batch-generate.js "data/*.json"');
  process.exit(1);
}

async function processFiles() {
  console.log('=== Batch PDF Generation ===\n');

  // Collect all JSON files
  let files = [];

  for (const arg of args) {
    const stat = fs.existsSync(arg) ? fs.statSync(arg) : null;

    if (stat && stat.isDirectory()) {
      // If directory, find all JSON files in it
      const dirFiles = fs.readdirSync(arg)
        .filter(f => f.endsWith('.json'))
        .map(f => path.join(arg, f));
      files.push(...dirFiles);
    } else if (stat && stat.isFile() && arg.endsWith('.json')) {
      // If file, add it
      files.push(arg);
    } else {
      // Try as glob pattern
      try {
        const matches = await glob(arg, { nodir: true });
        files.push(...matches.filter(f => f.endsWith('.json')));
      } catch (err) {
        console.warn(`Warning: Could not process pattern: ${arg}`);
      }
    }
  }

  // Remove duplicates
  files = [...new Set(files)];

  if (files.length === 0) {
    console.error('No JSON files found.');
    process.exit(1);
  }

  console.log(`Found ${files.length} file(s) to process:\n`);
  files.forEach((f, i) => console.log(`  ${i + 1}. ${f}`));
  console.log('');

  let successCount = 0;
  let failCount = 0;
  const results = [];

  for (let i = 0; i < files.length; i++) {
    const file = files[i];
    console.log(`\n${'='.repeat(60)}`);
    console.log(`Processing [${i + 1}/${files.length}]: ${path.basename(file)}`);
    console.log('='.repeat(60));

    try {
      // Format the document
      console.log('\n1. Formatting...');
      execSync(
        `node "${path.join(__dirname, 'format-document.js')}" "${file}"`,
        { stdio: 'inherit' }
      );

      // Generate PDF
      console.log('\n2. Generating PDF...');
      execSync(
        `node "${path.join(__dirname, 'generate-pdf.js')}" "${file}"`,
        { stdio: 'inherit' }
      );

      successCount++;
      results.push({ file, status: 'success' });
      console.log('\n✓ Success');

    } catch (error) {
      failCount++;
      results.push({ file, status: 'failed', error: error.message });
      console.error('\n✗ Failed:', error.message);
    }
  }

  // Summary
  console.log('\n' + '='.repeat(60));
  console.log('BATCH PROCESSING SUMMARY');
  console.log('='.repeat(60));
  console.log(`Total files: ${files.length}`);
  console.log(`Successful: ${successCount}`);
  console.log(`Failed: ${failCount}`);

  if (failCount > 0) {
    console.log('\nFailed files:');
    results
      .filter(r => r.status === 'failed')
      .forEach(r => console.log(`  - ${r.file}: ${r.error}`));
  }

  console.log('\n=== Batch processing complete ===');

  process.exit(failCount > 0 ? 1 : 0);
}

processFiles().catch(error => {
  console.error('Fatal error:', error);
  process.exit(1);
});
