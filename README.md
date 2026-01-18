# Helion Prime Financial Trust - Legal Notice Generator

Automated document generation system for creating professional legal notices, specifically designed for mortgage satisfaction and verification notices.

## Overview

This repository contains templates, scripts, and automation tools for generating standardized legal notices in both HTML and PDF formats. The system uses JSON data files to populate professional templates, ensuring consistency and accuracy across all generated documents.

## Features

- Professional HTML/CSS templates for legal notices
- Automated PDF generation from templates
- Data validation and formatting tools
- Standardized document structure
- Timestamp and document ID generation
- Currency and date formatting
- Command-line interface for easy automation

## Directory Structure

```
.
├── templates/              # Document templates
│   ├── mortgage-satisfaction-notice.html    # Main HTML template
│   └── notice-data-template.json           # Data structure template
├── scripts/               # Automation scripts
│   ├── generate-pdf.js    # PDF generation script
│   └── format-document.js # Data validation and formatting
├── examples/              # Example data files
│   └── example-data.json  # Sample notice data
├── output/                # Generated documents (PDF/HTML)
└── package.json           # Node.js dependencies
```

## Installation

### Prerequisites

- Node.js (v16 or higher)
- npm (Node Package Manager)

### Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd Helion-Prime-financial-Legal-Notice-Of-Verification-and-Satisfaction-Of-Mortgage
```

2. Install dependencies:
```bash
npm install
```

This will install:
- `puppeteer` - For HTML to PDF conversion
- `handlebars` - For template processing
- `yargs` - For command-line argument parsing

## Usage

### 1. Prepare Your Data

Create a JSON file with your notice data using the template structure:

```json
{
  "documentInfo": {
    "DOCUMENT_ID": "HSM-2021-000001",
    "NOTICE_DATE": "June 23, 2021"
  },
  "mortgageInfo": {
    "MORTGAGE_DATE": "January 15, 2005",
    "MORTGAGE_REF_NUMBER": "2005-001234-MTG",
    "RECORDING_OFFICE": "County Clerk's Office, County Name, State",
    "RECORDING_DATE": "January 20, 2005",
    "BOOK_VOLUME": "12345",
    "PAGE_NUMBER": "678"
  },
  "propertyInfo": {
    "PROPERTY_ADDRESS": "123 Main Street",
    "PROPERTY_CITY_STATE_ZIP": "Anytown, State 12345",
    "LEGAL_DESCRIPTION": "Lot 10, Block 5, Subdivision Name",
    "PARCEL_ID": "12-34-567-890-001"
  },
  "parties": {
    "BORROWER_NAME": "John Doe and Jane Doe",
    "LENDER_NAME": "Original Lender Bank, N.A.",
    "CURRENT_MORTGAGEE": "Helion Prime Financial Trust",
    "SERVICER_NAME": "N/A"
  },
  "satisfactionDetails": {
    "ORIGINAL_AMOUNT": "$250,000.00",
    "SATISFACTION_DATE": "June 15, 2021",
    "FINAL_PAYMENT_DATE": "June 10, 2021",
    "SATISFACTION_METHOD": "Full Payment"
  },
  "additionalInfo": {
    "ADDITIONAL_NOTES": "All obligations satisfied.",
    "CONTACT_INFO": "legal@helionprimefinancial.com",
    "VERIFICATION_URL": "https://verify.helionprimefinancial.com",
    "FOOTER_CONTACT_INFO": "123 Financial Plaza, City, State"
  },
  "authorization": {
    "AUTHORIZED_NAME": "Robert Smith",
    "AUTHORIZED_TITLE": "Vice President, Legal Affairs",
    "ORGANIZATION_NAME": "Helion Prime Financial Trust",
    "SIGNATURE_DATE": "June 23, 2021"
  }
}
```

### 2. Validate and Format Data (Optional but Recommended)

Before generating documents, validate and format your data:

```bash
node scripts/format-document.js your-data.json
```

Options:
- `--output, -o` - Save to a different file
- `--validate, -v` - Only validate without formatting
- `--strict, -s` - Use strict validation mode

Example:
```bash
# Validate and format, overwriting the original
node scripts/format-document.js examples/example-data.json

# Validate only without changes
node scripts/format-document.js examples/example-data.json --validate

# Format and save to new file
node scripts/format-document.js examples/example-data.json -o examples/formatted-data.json
```

### 3. Generate PDF

Generate a PDF document from your data:

```bash
node scripts/generate-pdf.js your-data.json
```

Options:
- `--template, -t` - Specify custom template (default: `templates/mortgage-satisfaction-notice.html`)
- `--output, -o` - Specify output filename (default: `output/notice-{timestamp}.pdf`)
- `--format, -f` - Page format: Letter, A4, or Legal (default: Letter)

Examples:
```bash
# Basic generation
node scripts/generate-pdf.js examples/example-data.json

# Custom output filename
node scripts/generate-pdf.js examples/example-data.json -o output/my-notice.pdf

# Use A4 page format
node scripts/generate-pdf.js examples/example-data.json -f A4

# Custom template
node scripts/generate-pdf.js examples/example-data.json -t templates/custom-template.html
```

### 4. Using NPM Scripts

Convenient npm scripts are available:

```bash
# Generate with example data
npm run generate-example

# General generate (requires data file as argument)
npm run generate -- examples/example-data.json

# Format document
npm run format -- examples/example-data.json
```

## Template Customization

### Modifying the HTML Template

The main template is located at `templates/mortgage-satisfaction-notice.html`. It uses placeholder variables in the format `{{VARIABLE_NAME}}`.

To customize:

1. Edit the HTML structure and styling
2. Add new placeholders using `{{YOUR_FIELD_NAME}}`
3. Update your JSON data to include the new fields

### CSS Styling

The template includes embedded CSS for professional formatting. Key classes:

- `.document-header` - Header section styling
- `.section` - Main content sections
- `.field-group` - Field label/value pairs
- `.signature-section` - Signature and authorization area
- `.legal-disclaimer` - Disclaimer box styling

### Print Optimization

The template includes print-specific styles using `@media print` for optimal PDF generation.

## Data Validation

The formatting script validates required fields:

### Required Fields:
- **documentInfo**: DOCUMENT_ID, NOTICE_DATE
- **mortgageInfo**: MORTGAGE_DATE, MORTGAGE_REF_NUMBER, RECORDING_OFFICE
- **propertyInfo**: PROPERTY_ADDRESS, PROPERTY_CITY_STATE_ZIP
- **parties**: BORROWER_NAME, LENDER_NAME, CURRENT_MORTGAGEE
- **satisfactionDetails**: SATISFACTION_DATE
- **authorization**: AUTHORIZED_NAME, AUTHORIZED_TITLE, ORGANIZATION_NAME

### Automatic Formatting:
- Dates are formatted to "Month Day, Year" format
- Currency values are formatted with $ and proper commas
- Document IDs are auto-generated if missing
- Timestamps are added automatically
- All string values are trimmed

## Output

The PDF generation script creates:

1. **PDF File** - Final formatted legal notice (e.g., `output/HSM-2021-000001-2021-06-23.pdf`)
2. **HTML File** - Populated HTML for reference (e.g., `output/HSM-2021-000001-2021-06-23.html`)

Both files are saved in the `output/` directory.

## Troubleshooting

### Puppeteer Installation Issues

If Puppeteer fails to install, try:
```bash
npm install puppeteer --unsafe-perm=true --allow-root
```

Or use the system Chrome/Chromium:
```bash
PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true npm install
```

### Missing Dependencies

Ensure all dependencies are installed:
```bash
npm install
```

### Permission Errors

Make scripts executable:
```bash
chmod +x scripts/*.js
```

## Advanced Usage

### Batch Processing

Process multiple notices:

```bash
for file in data/*.json; do
  node scripts/format-document.js "$file"
  node scripts/generate-pdf.js "$file"
done
```

### Custom Templates

Create your own template:

1. Copy `templates/mortgage-satisfaction-notice.html` to a new file
2. Modify the structure and styling
3. Use it with the `-t` option:
```bash
node scripts/generate-pdf.js data.json -t templates/my-template.html
```

### Integration with Other Systems

The scripts can be imported as modules:

```javascript
const { generatePDF, populateTemplate } = require('./scripts/generate-pdf');
const { validateData, formatData } = require('./scripts/format-document');

// Use in your own code
const data = formatData(rawData);
const validation = validateData(data);
// ...
```

## Legal Notice

This system generates legal documents. Always ensure:

1. Data accuracy and completeness
2. Proper authorization before generating notices
3. Legal review of generated documents
4. Compliance with local recording requirements
5. Proper storage and retention of generated documents

## Support

For issues or questions:
- Email: legal@helionprimefinancial.com
- Phone: (555) 123-4567

## License

MIT License - See LICENSE file for details

## Version History

- **v1.0.0** (2021) - Initial release
  - HTML/CSS templates
  - PDF generation
  - Data validation
  - Automated formatting

---

**Helion Prime Financial Trust**
*Professional Legal Document Management*
