# Quick Usage Guide

## Getting Started in 5 Minutes

### 1. Install Dependencies
```bash
npm install
```

### 2. Try the Quick Start Demo
```bash
npm run quick-start
```

This will:
- Validate and format the example data
- Generate a sample PDF in the `output/` folder
- Show you the complete workflow

### 3. View Your Generated Document
Check the `output/` directory for:
- `HSM-2021-000001-[date].pdf` - Your generated PDF
- `HSM-2021-000001-[date].html` - HTML version for reference

---

## Creating Your Own Legal Notice

### Method 1: Quick Template Creation
```bash
npm run new-template -- my-notice.json
```

Edit the generated file, then:
```bash
npm run format -- my-notice.json
npm run generate -- my-notice.json
```

### Method 2: Copy and Edit Example
```bash
cp examples/example-data.json my-notice.json
# Edit my-notice.json with your data
npm run format -- my-notice.json
npm run generate -- my-notice.json
```

### Method 3: Start from Scratch
Copy `templates/notice-data-template.json` and fill in all fields.

---

## Common Commands

### Generate a Single PDF
```bash
node scripts/generate-pdf.js your-data.json
```

### Validate Data
```bash
node scripts/format-document.js your-data.json --validate
```

### Format and Auto-Fix Data
```bash
node scripts/format-document.js your-data.json
```

### Batch Process Multiple Files
```bash
npm run batch -- data/*.json
```

Or for a directory:
```bash
npm run batch -- data/
```

### Custom Output Location
```bash
node scripts/generate-pdf.js your-data.json -o custom-output.pdf
```

### Use A4 Paper Format
```bash
node scripts/generate-pdf.js your-data.json -f A4
```

---

## Required Data Fields

When creating your notice, these fields are **required**:

### Document Info
- `DOCUMENT_ID` - Unique identifier (auto-generated if missing)
- `NOTICE_DATE` - Date of the notice

### Mortgage Info
- `MORTGAGE_DATE` - Original mortgage date
- `MORTGAGE_REF_NUMBER` - Reference/loan number
- `RECORDING_OFFICE` - Where mortgage was recorded

### Property Info
- `PROPERTY_ADDRESS` - Street address
- `PROPERTY_CITY_STATE_ZIP` - City, state, and ZIP

### Parties
- `BORROWER_NAME` - Name(s) of borrower(s)
- `LENDER_NAME` - Original lender
- `CURRENT_MORTGAGEE` - Current holder

### Satisfaction Details
- `SATISFACTION_DATE` - When mortgage was satisfied

### Authorization
- `AUTHORIZED_NAME` - Person signing
- `AUTHORIZED_TITLE` - Their title
- `ORGANIZATION_NAME` - Organization name

---

## Tips and Best Practices

### 1. Always Validate First
```bash
npm run format -- your-data.json --validate
```

### 2. Use Meaningful Document IDs
Follow the pattern: `HSM-YYYY-NNNNNN`
- HSM = Helion Satisfaction of Mortgage
- YYYY = Year
- NNNNNN = Sequential number

### 3. Check Generated Files
Before finalizing, review both:
- The PDF (final output)
- The HTML (easier to check details)

### 4. Keep Backups
Save your JSON data files - they're your source of truth.

### 5. Batch Processing
For multiple notices, organize files in a directory:
```
data/
  ├── notice-001.json
  ├── notice-002.json
  └── notice-003.json
```

Then run:
```bash
npm run batch -- data/
```

---

## Troubleshooting

### "Missing required field" Error
Run with validation to see which fields are missing:
```bash
node scripts/format-document.js your-data.json --validate --strict
```

### PDF Generation Fails
1. Ensure all dependencies are installed: `npm install`
2. Check your JSON is valid: `node -e "console.log(JSON.parse(require('fs').readFileSync('your-file.json')))"`
3. Try the example file first: `npm run generate-example`

### Puppeteer Issues
If Puppeteer fails to install:
```bash
npm install puppeteer --unsafe-perm=true
```

Or skip the download and use system Chrome:
```bash
PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true npm install
```

---

## Workflow Examples

### Single Document Workflow
```bash
# Create from template
npm run new-template -- notice.json

# Edit notice.json with your data
nano notice.json

# Validate
npm run format -- notice.json --validate

# Format and generate
npm run format -- notice.json
npm run generate -- notice.json

# Check output/
ls -l output/
```

### Batch Document Workflow
```bash
# Create multiple templates
npm run new-template -- data/notice1.json
npm run new-template -- data/notice2.json
npm run new-template -- data/notice3.json

# Edit all files...

# Batch process
npm run batch -- data/
```

### Update Existing Document
```bash
# Edit your existing data file
nano my-notice.json

# Regenerate
npm run format -- my-notice.json
npm run generate -- my-notice.json -o output/updated-notice.pdf
```

---

## File Locations

```
Project Structure:
├── templates/          ← Template files
├── scripts/            ← Automation scripts
├── examples/           ← Example data
├── output/             ← Generated PDFs/HTML (you create this)
└── data/               ← Your data files (you create this)
```

---

## Next Steps

1. Read the full [README.md](README.md) for detailed documentation
2. Examine `examples/example-data.json` to understand the data structure
3. Look at `templates/mortgage-satisfaction-notice.html` to see the template
4. Create your first notice using `npm run new-template`

---

## Support

Questions? Check:
- [README.md](README.md) - Full documentation
- `examples/` directory - Working examples
- `templates/` directory - Template reference

For issues: legal@helionprimefinancial.com
