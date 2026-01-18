#!/usr/bin/env node

/**
 * PDF Generation Script for Legal Notices
 * Generates professional PDF documents from HTML templates and JSON data
 *
 * Usage:
 *   node scripts/generate-pdf.js [data-file.json] [options]
 *
 * Options:
 *   --template, -t    Path to HTML template (default: templates/mortgage-satisfaction-notice.html)
 *   --output, -o      Output PDF filename (default: output/notice-{timestamp}.pdf)
 *   --data, -d        Path to JSON data file
 *   --format, -f      Page format (default: Letter)
 */

const fs = require('fs');
const path = require('path');
const puppeteer = require('puppeteer');
const Handlebars = require('handlebars');
const yargs = require('yargs/yargs');
const { hideBin } = require('yargs/helpers');

// Parse command line arguments
const argv = yargs(hideBin(process.argv))
  .usage('Usage: $0 [data-file.json] [options]')
  .option('template', {
    alias: 't',
    describe: 'Path to HTML template file',
    type: 'string',
    default: 'templates/mortgage-satisfaction-notice.html'
  })
  .option('output', {
    alias: 'o',
    describe: 'Output PDF filename',
    type: 'string'
  })
  .option('data', {
    alias: 'd',
    describe: 'Path to JSON data file',
    type: 'string'
  })
  .option('format', {
    alias: 'f',
    describe: 'Page format (Letter, A4, Legal)',
    type: 'string',
    default: 'Letter'
  })
  .help()
  .alias('help', 'h')
  .argv;

/**
 * Load and parse JSON data file
 */
function loadDataFile(filePath) {
  try {
    const absolutePath = path.resolve(filePath);
    const fileContent = fs.readFileSync(absolutePath, 'utf8');
    return JSON.parse(fileContent);
  } catch (error) {
    console.error(`Error loading data file: ${error.message}`);
    process.exit(1);
  }
}

/**
 * Load HTML template file
 */
function loadTemplate(filePath) {
  try {
    const absolutePath = path.resolve(filePath);
    return fs.readFileSync(absolutePath, 'utf8');
  } catch (error) {
    console.error(`Error loading template file: ${error.message}`);
    process.exit(1);
  }
}

/**
 * Flatten nested JSON data for template placeholders
 */
function flattenData(data) {
  const flattened = {};

  function flatten(obj, prefix = '') {
    for (const key in obj) {
      if (typeof obj[key] === 'object' && obj[key] !== null && !Array.isArray(obj[key])) {
        flatten(obj[key], prefix);
      } else {
        flattened[key] = obj[key];
      }
    }
  }

  flatten(data);
  return flattened;
}

/**
 * Replace template placeholders with actual data
 */
function populateTemplate(templateHtml, data) {
  const flatData = flattenData(data);

  // Use Handlebars for template rendering
  const template = Handlebars.compile(templateHtml, { noEscape: true });

  // Replace {{PLACEHOLDER}} style
  let populated = template(flatData);

  // Also handle direct replacement for any remaining {{PLACEHOLDER}} patterns
  for (const [key, value] of Object.entries(flatData)) {
    const placeholder = new RegExp(`{{${key}}}`, 'g');
    populated = populated.replace(placeholder, value || '');
  }

  return populated;
}

/**
 * Generate PDF from HTML content
 */
async function generatePDF(htmlContent, outputPath, format = 'Letter') {
  let browser;

  try {
    console.log('Launching browser...');
    browser = await puppeteer.launch({
      headless: 'new',
      args: ['--no-sandbox', '--disable-setuid-sandbox']
    });

    const page = await browser.newPage();

    console.log('Loading HTML content...');
    await page.setContent(htmlContent, {
      waitUntil: 'networkidle0'
    });

    console.log('Generating PDF...');
    await page.pdf({
      path: outputPath,
      format: format,
      printBackground: true,
      margin: {
        top: '0.5in',
        right: '0.5in',
        bottom: '0.5in',
        left: '0.5in'
      }
    });

    console.log(`✓ PDF generated successfully: ${outputPath}`);

  } catch (error) {
    console.error(`Error generating PDF: ${error.message}`);
    process.exit(1);
  } finally {
    if (browser) {
      await browser.close();
    }
  }
}

/**
 * Main execution function
 */
async function main() {
  console.log('=== Helion Prime Legal Notice PDF Generator ===\n');

  // Determine data file path
  let dataFilePath = argv.data;
  if (!dataFilePath && argv._.length > 0) {
    dataFilePath = argv._[0];
  }

  if (!dataFilePath) {
    console.error('Error: No data file specified.');
    console.log('Usage: node scripts/generate-pdf.js <data-file.json>');
    console.log('   or: node scripts/generate-pdf.js --data <data-file.json>');
    process.exit(1);
  }

  // Load data and template
  console.log(`Loading data from: ${dataFilePath}`);
  const data = loadDataFile(dataFilePath);

  console.log(`Loading template from: ${argv.template}`);
  const templateHtml = loadTemplate(argv.template);

  // Populate template with data
  console.log('Populating template with data...');
  const populatedHtml = populateTemplate(templateHtml, data);

  // Determine output path
  let outputPath = argv.output;
  if (!outputPath) {
    const timestamp = new Date().toISOString().replace(/[:.]/g, '-').split('T')[0];
    const docId = data.documentInfo?.DOCUMENT_ID || 'notice';
    outputPath = `output/${docId}-${timestamp}.pdf`;
  }

  // Ensure output directory exists
  const outputDir = path.dirname(outputPath);
  if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir, { recursive: true });
  }

  // Generate PDF
  await generatePDF(populatedHtml, outputPath, argv.format);

  // Also save the populated HTML for reference
  const htmlOutputPath = outputPath.replace('.pdf', '.html');
  fs.writeFileSync(htmlOutputPath, populatedHtml);
  console.log(`✓ HTML saved for reference: ${htmlOutputPath}`);

  console.log('\n=== Generation Complete ===');
  console.log(`Document ID: ${data.documentInfo?.DOCUMENT_ID || 'N/A'}`);
  console.log(`Output PDF: ${outputPath}`);
  console.log(`Output HTML: ${htmlOutputPath}`);
}

// Execute main function
if (require.main === module) {
  main().catch(error => {
    console.error('Fatal error:', error);
    process.exit(1);
  });
}

module.exports = { generatePDF, populateTemplate, flattenData };
