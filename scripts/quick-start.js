#!/usr/bin/env node

/**
 * Quick Start Script
 * Demonstrates the complete workflow: validate, format, and generate PDF
 */

const { execSync } = require('child_process');
const path = require('path');
const fs = require('fs');

console.log('=== Helion Prime Legal Notice Generator - Quick Start ===\n');

const exampleFile = path.join(__dirname, '..', 'examples', 'example-data.json');

if (!fs.existsSync(exampleFile)) {
  console.error('Error: Example data file not found.');
  console.error('Expected location:', exampleFile);
  process.exit(1);
}

try {
  // Step 1: Validate and format
  console.log('Step 1: Validating and formatting data...');
  execSync(`node "${path.join(__dirname, 'format-document.js')}" "${exampleFile}"`, {
    stdio: 'inherit'
  });

  console.log('\n' + '='.repeat(60) + '\n');

  // Step 2: Generate PDF
  console.log('Step 2: Generating PDF document...');
  execSync(`node "${path.join(__dirname, 'generate-pdf.js')}" "${exampleFile}"`, {
    stdio: 'inherit'
  });

  console.log('\n' + '='.repeat(60) + '\n');
  console.log('✓ Quick start complete!');
  console.log('\nGenerated files are in the output/ directory.');
  console.log('\nNext steps:');
  console.log('1. Review the generated PDF in output/');
  console.log('2. Create your own data file using templates/notice-data-template.json');
  console.log('3. Run: node scripts/generate-pdf.js your-data.json');
  console.log('\nFor more information, see README.md');

} catch (error) {
  console.error('\nError during quick start:', error.message);
  process.exit(1);
}
