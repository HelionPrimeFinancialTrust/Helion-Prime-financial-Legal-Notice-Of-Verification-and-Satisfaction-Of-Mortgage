#!/usr/bin/env node

/**
 * HTML-Only Generator (for demo purposes when Puppeteer is unavailable)
 * Generates populated HTML without PDF conversion
 */

const fs = require('fs');
const path = require('path');
const Handlebars = require('handlebars');

function loadDataFile(filePath) {
  const content = fs.readFileSync(filePath, 'utf8');
  return JSON.parse(content);
}

function loadTemplate(filePath) {
  return fs.readFileSync(filePath, 'utf8');
}

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

function populateTemplate(templateHtml, data) {
  const flatData = flattenData(data);
  const template = Handlebars.compile(templateHtml, { noEscape: true });
  let populated = template(flatData);

  for (const [key, value] of Object.entries(flatData)) {
    const placeholder = new RegExp(`{{${key}}}`, 'g');
    populated = populated.replace(placeholder, value || '');
  }

  return populated;
}

const dataFile = process.argv[2] || 'examples/example-data.json';
const outputFile = process.argv[3] || 'output/generated-notice.html';

console.log('=== HTML Generator (PDF generation unavailable) ===\n');
console.log(`Loading data from: ${dataFile}`);

const data = loadDataFile(dataFile);
const template = loadTemplate('templates/mortgage-satisfaction-notice.html');

console.log('Populating template...');
const html = populateTemplate(template, data);

// Ensure output directory exists
const outputDir = path.dirname(outputFile);
if (!fs.existsSync(outputDir)) {
  fs.mkdirSync(outputDir, { recursive: true });
}

fs.writeFileSync(outputFile, html);

console.log(`✓ HTML generated: ${outputFile}`);
console.log(`\nYou can open this file in a browser to view the formatted document.`);
console.log(`\nNote: PDF generation requires Puppeteer browser to be installed.`);
console.log(`To enable PDF generation, run: npx puppeteer browsers install chrome`);
