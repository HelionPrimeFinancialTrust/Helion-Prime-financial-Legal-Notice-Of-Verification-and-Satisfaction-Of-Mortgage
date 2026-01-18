#!/usr/bin/env node

/**
 * Template Creation Script
 * Creates a new data file from the template
 *
 * Usage:
 *   node scripts/create-template.js <output-filename>
 */

const fs = require('fs');
const path = require('path');
const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function question(query) {
  return new Promise(resolve => rl.question(query, resolve));
}

async function main() {
  console.log('=== New Legal Notice Template Creator ===\n');

  const args = process.argv.slice(2);
  let outputFile = args[0];

  if (!outputFile) {
    outputFile = await question('Enter output filename (e.g., my-notice.json): ');
  }

  if (!outputFile.endsWith('.json')) {
    outputFile += '.json';
  }

  // Check if file exists
  if (fs.existsSync(outputFile)) {
    const overwrite = await question(`File ${outputFile} already exists. Overwrite? (y/n): `);
    if (overwrite.toLowerCase() !== 'y') {
      console.log('Operation cancelled.');
      rl.close();
      return;
    }
  }

  console.log('\nCreating new template...');

  // Load the template
  const templatePath = path.join(__dirname, '..', 'templates', 'notice-data-template.json');
  const template = JSON.parse(fs.readFileSync(templatePath, 'utf8'));

  // Update document ID and dates
  const now = new Date();
  const year = now.getFullYear();
  const random = Math.floor(Math.random() * 1000000).toString().padStart(6, '0');

  template.documentInfo.DOCUMENT_ID = `HSM-${year}-${random}`;
  template.documentInfo.NOTICE_DATE = now.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  });
  template.documentInfo.GENERATION_TIMESTAMP = now.toLocaleString('en-US', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
    timeZoneName: 'short'
  });

  // Save the new file
  fs.writeFileSync(outputFile, JSON.stringify(template, null, 2), 'utf8');

  console.log(`\n✓ Template created: ${outputFile}`);
  console.log(`  Document ID: ${template.documentInfo.DOCUMENT_ID}`);
  console.log('\nNext steps:');
  console.log(`1. Edit ${outputFile} with your data`);
  console.log(`2. Validate: npm run format -- ${outputFile}`);
  console.log(`3. Generate PDF: npm run generate -- ${outputFile}`);

  rl.close();
}

main().catch(error => {
  console.error('Error:', error.message);
  rl.close();
  process.exit(1);
});
