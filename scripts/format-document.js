#!/usr/bin/env node

/**
 * Document Formatting and Validation Script
 * Validates, formats, and standardizes legal notice data
 *
 * Usage:
 *   node scripts/format-document.js <input-file.json> [options]
 *
 * Options:
 *   --output, -o      Output formatted JSON file (default: overwrites input)
 *   --validate, -v    Only validate without formatting
 *   --strict, -s      Use strict validation mode
 */

const fs = require('fs');
const path = require('path');
const yargs = require('yargs/yargs');
const { hideBin } = require('yargs/helpers');

const argv = yargs(hideBin(process.argv))
  .usage('Usage: $0 <input-file.json> [options]')
  .option('output', {
    alias: 'o',
    describe: 'Output formatted JSON file',
    type: 'string'
  })
  .option('validate', {
    alias: 'v',
    describe: 'Only validate without formatting',
    type: 'boolean',
    default: false
  })
  .option('strict', {
    alias: 's',
    describe: 'Use strict validation mode',
    type: 'boolean',
    default: false
  })
  .demandCommand(1, 'Please provide an input JSON file')
  .help()
  .alias('help', 'h')
  .argv;

// Required fields for validation
const REQUIRED_FIELDS = {
  documentInfo: ['DOCUMENT_ID', 'NOTICE_DATE'],
  mortgageInfo: ['MORTGAGE_DATE', 'MORTGAGE_REF_NUMBER', 'RECORDING_OFFICE'],
  propertyInfo: ['PROPERTY_ADDRESS', 'PROPERTY_CITY_STATE_ZIP'],
  parties: ['BORROWER_NAME', 'LENDER_NAME', 'CURRENT_MORTGAGEE'],
  satisfactionDetails: ['SATISFACTION_DATE'],
  authorization: ['AUTHORIZED_NAME', 'AUTHORIZED_TITLE', 'ORGANIZATION_NAME']
};

// Optional fields
const OPTIONAL_FIELDS = {
  mortgageInfo: ['RECORDING_DATE', 'BOOK_VOLUME', 'PAGE_NUMBER'],
  propertyInfo: ['LEGAL_DESCRIPTION', 'PARCEL_ID'],
  parties: ['SERVICER_NAME'],
  satisfactionDetails: ['ORIGINAL_AMOUNT', 'FINAL_PAYMENT_DATE', 'SATISFACTION_METHOD'],
  additionalInfo: ['ADDITIONAL_NOTES', 'CONTACT_INFO', 'VERIFICATION_URL', 'FOOTER_CONTACT_INFO'],
  authorization: ['SIGNATURE_DATE']
};

/**
 * Load JSON file
 */
function loadJSON(filePath) {
  try {
    const content = fs.readFileSync(filePath, 'utf8');
    return JSON.parse(content);
  } catch (error) {
    console.error(`Error loading file: ${error.message}`);
    process.exit(1);
  }
}

/**
 * Save JSON file with pretty formatting
 */
function saveJSON(filePath, data) {
  try {
    const content = JSON.stringify(data, null, 2);
    fs.writeFileSync(filePath, content, 'utf8');
    console.log(`✓ File saved: ${filePath}`);
  } catch (error) {
    console.error(`Error saving file: ${error.message}`);
    process.exit(1);
  }
}

/**
 * Validate data structure
 */
function validateData(data, strict = false) {
  const errors = [];
  const warnings = [];

  // Check for required sections
  for (const [section, fields] of Object.entries(REQUIRED_FIELDS)) {
    if (!data[section]) {
      errors.push(`Missing required section: ${section}`);
      continue;
    }

    // Check for required fields in each section
    for (const field of fields) {
      if (!data[section][field] || data[section][field].trim() === '') {
        errors.push(`Missing required field: ${section}.${field}`);
      }
    }
  }

  // Check for optional fields in strict mode
  if (strict) {
    for (const [section, fields] of Object.entries(OPTIONAL_FIELDS)) {
      if (data[section]) {
        for (const field of fields) {
          if (!data[section][field] || data[section][field].trim() === '') {
            warnings.push(`Optional field empty: ${section}.${field}`);
          }
        }
      }
    }
  }

  return { errors, warnings };
}

/**
 * Format currency values
 */
function formatCurrency(value) {
  if (!value) return value;

  // Remove any non-numeric characters except decimal point
  const numeric = value.toString().replace(/[^0-9.]/g, '');
  const number = parseFloat(numeric);

  if (isNaN(number)) return value;

  return `$${number.toLocaleString('en-US', {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2
  })}`;
}

/**
 * Format date to consistent format
 */
function formatDate(dateString) {
  if (!dateString) return dateString;

  try {
    const date = new Date(dateString);
    if (isNaN(date.getTime())) return dateString;

    return date.toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  } catch {
    return dateString;
  }
}

/**
 * Generate document ID if missing
 */
function generateDocumentId() {
  const year = new Date().getFullYear();
  const random = Math.floor(Math.random() * 1000000).toString().padStart(6, '0');
  return `HSM-${year}-${random}`;
}

/**
 * Generate timestamp
 */
function generateTimestamp() {
  return new Date().toLocaleString('en-US', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
    timeZoneName: 'short'
  });
}

/**
 * Format and standardize document data
 */
function formatData(data) {
  const formatted = JSON.parse(JSON.stringify(data)); // Deep copy

  // Ensure all sections exist
  formatted.documentInfo = formatted.documentInfo || {};
  formatted.mortgageInfo = formatted.mortgageInfo || {};
  formatted.propertyInfo = formatted.propertyInfo || {};
  formatted.parties = formatted.parties || {};
  formatted.satisfactionDetails = formatted.satisfactionDetails || {};
  formatted.additionalInfo = formatted.additionalInfo || {};
  formatted.authorization = formatted.authorization || {};

  // Format document info
  if (!formatted.documentInfo.DOCUMENT_ID) {
    formatted.documentInfo.DOCUMENT_ID = generateDocumentId();
    console.log(`Generated Document ID: ${formatted.documentInfo.DOCUMENT_ID}`);
  }

  if (!formatted.documentInfo.GENERATION_TIMESTAMP) {
    formatted.documentInfo.GENERATION_TIMESTAMP = generateTimestamp();
  }

  // Format dates
  const dateFields = [
    ['documentInfo', 'NOTICE_DATE'],
    ['mortgageInfo', 'MORTGAGE_DATE'],
    ['mortgageInfo', 'RECORDING_DATE'],
    ['satisfactionDetails', 'SATISFACTION_DATE'],
    ['satisfactionDetails', 'FINAL_PAYMENT_DATE'],
    ['authorization', 'SIGNATURE_DATE']
  ];

  for (const [section, field] of dateFields) {
    if (formatted[section] && formatted[section][field]) {
      formatted[section][field] = formatDate(formatted[section][field]);
    }
  }

  // Format currency
  if (formatted.satisfactionDetails.ORIGINAL_AMOUNT) {
    formatted.satisfactionDetails.ORIGINAL_AMOUNT = formatCurrency(
      formatted.satisfactionDetails.ORIGINAL_AMOUNT
    );
  }

  // Trim all string values
  for (const section in formatted) {
    if (typeof formatted[section] === 'object') {
      for (const field in formatted[section]) {
        if (typeof formatted[section][field] === 'string') {
          formatted[section][field] = formatted[section][field].trim();
        }
      }
    }
  }

  return formatted;
}

/**
 * Main execution function
 */
function main() {
  console.log('=== Document Formatting and Validation Tool ===\n');

  const inputFile = argv._[0];
  console.log(`Loading: ${inputFile}`);

  const data = loadJSON(inputFile);

  // Validate
  console.log('\nValidating document data...');
  const { errors, warnings } = validateData(data, argv.strict);

  if (errors.length > 0) {
    console.error('\n❌ Validation Errors:');
    errors.forEach(err => console.error(`  - ${err}`));
  }

  if (warnings.length > 0) {
    console.warn('\n⚠️  Warnings:');
    warnings.forEach(warn => console.warn(`  - ${warn}`));
  }

  if (errors.length === 0) {
    console.log('✓ Validation passed');
  } else {
    console.error('\nValidation failed. Please fix errors before proceeding.');
    process.exit(1);
  }

  // Format if not in validate-only mode
  if (!argv.validate) {
    console.log('\nFormatting document data...');
    const formatted = formatData(data);

    const outputFile = argv.output || inputFile;
    saveJSON(outputFile, formatted);

    console.log('\n✓ Formatting complete');
  }

  console.log('\n=== Done ===');
}

// Execute
if (require.main === module) {
  main();
}

module.exports = { validateData, formatData, formatCurrency, formatDate };
