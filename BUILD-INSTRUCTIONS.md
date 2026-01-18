# Building the iOS App - Quick Start Guide

## Prerequisites

✅ **Required:**
- Mac computer (macOS 13.0 or later)
- Xcode 15.0 or later (free from Mac App Store)
- Apple ID for code signing

## Step-by-Step Build Instructions

### 1. Get the Files

If you haven't already cloned the repository:

```bash
git clone <your-repo-url>
cd Helion-Prime-financial-Legal-Notice-Of-Verification-and-Satisfaction-Of-Mortgage
```

### 2. Open in Xcode

**Option A: Using Finder**
- Navigate to the project folder
- Double-click `LegalDocGenerator.xcodeproj`

**Option B: Using Terminal**
```bash
open LegalDocGenerator.xcodeproj
```

### 3. Configure Code Signing

When Xcode opens:

1. Click on the **LegalDocGenerator** project in the left sidebar
2. Select the **LegalDocGenerator** target
3. Go to **Signing & Capabilities** tab
4. Check **"Automatically manage signing"**
5. Select your **Team** (your Apple ID)
6. Xcode will automatically create a provisioning profile

### 4. Choose Your Destination

In Xcode's toolbar at the top:

**For Simulator:**
- Click the device menu (next to the play button)
- Select "iPhone 15 Pro" or any iOS 16.0+ simulator
- Click the ▶️ Play button (or press Cmd+R)

**For Physical Device:**
- Connect your iPhone/iPad via USB
- Select your device from the menu
- Click the ▶️ Play button

**First Time on Physical Device:**
- Go to Settings > General > VPN & Device Management
- Trust the developer certificate

### 5. Build and Run

Press **⌘R** (Command + R) or click the ▶️ Play button

Xcode will:
1. Compile the Swift code
2. Build the app
3. Install on simulator/device
4. Launch automatically

### 6. Verify It Works

Once the app launches:

1. ✅ You should see the "Legal Documents" main screen
2. ✅ Tap the **+** button in top right
3. ✅ Grid of 10 document types should appear
4. ✅ Select "Non-Disclosure Agreement"
5. ✅ Fill in some test data
6. ✅ Tap "Export as Word Document"
7. ✅ Share sheet should appear with the .docx file

## Troubleshooting

### "No Development Team Found"

**Solution:**
1. Go to Xcode > Settings > Accounts
2. Click **+** and add your Apple ID
3. Go back to Signing & Capabilities and select your team

### "Failed to Code Sign"

**Solution:**
1. In Xcode, go to Product > Clean Build Folder (Shift+Cmd+K)
2. Change Bundle Identifier to something unique:
   - `com.yourname.legaldocgenerator`
3. Build again

### "Build Failed" Errors

**Solution:**
1. Make sure you have Xcode 15.0 or later
2. Clean build folder: Product > Clean Build Folder
3. Check iOS Deployment Target is 16.0+

### App Crashes on Launch

**Solution:**
1. Check the Xcode console for error messages
2. Verify all Swift files compiled successfully
3. Try running on different simulator

### Export Functions Don't Work

This is normal for now! The Word export creates XML, but for full .docx compatibility:

**To enhance Word export:**
- Consider integrating a full .docx library like:
  - `ZipArchive` for creating proper .docx ZIP structure
  - Or use a Swift package for Office document generation

**Current functionality:**
- ✅ PDF export works perfectly
- ✅ Text export works perfectly
- ⚠️ Word export creates XML (may need additional processing)

## Testing the App

### Test Each Document Type

1. **Mortgage Satisfaction Notice**
   - Fill in: Borrower, Lender, Property, Amount, Date
   - Export to PDF
   - Verify all fields appear

2. **NDA**
   - Fill in: Both parties, Date, Term, Law
   - Export to PDF
   - Check professional formatting

3. **Other Types**
   - Test each document type
   - Verify required fields validation works
   - Check export functionality

### Test Features

- [ ] Create document
- [ ] Edit document
- [ ] Delete document (swipe left)
- [ ] Export to Word
- [ ] Export to PDF
- [ ] Export to Text
- [ ] Share via iOS share sheet
- [ ] Save to Files app
- [ ] Dark mode (toggle in iOS Settings)
- [ ] iPad layout

## Customization Tips

### Change App Name
In `Info.plist`:
```xml
<key>CFBundleDisplayName</key>
<string>Your App Name</string>
```

### Change Bundle ID
In Xcode project settings:
```
com.yourcompany.yourappname
```

### Modify Templates
Edit files in `LegalDocGenerator/Templates/`

### Add Document Type
1. Edit `DocumentType.swift` - add new case
2. Create new template file
3. Update all switch statements

### Change Colors/Styling
Modify SwiftUI views in `Views/` folder

## Deployment

### TestFlight (Beta Testing)
1. Archive the app: Product > Archive
2. Upload to App Store Connect
3. Add testers
4. Distribute

### App Store
1. Create app in App Store Connect
2. Archive and upload
3. Submit for review
4. Apple reviews in 1-3 days

## Performance Tips

### For Production Use

**Consider upgrading:**

1. **Storage**: Replace UserDefaults with Core Data
   - Better performance
   - Query capabilities
   - Relationships

2. **Word Export**: Use proper .docx library
   - Full Microsoft Word compatibility
   - Advanced formatting
   - Template support

3. **Cloud Sync**: Add iCloud/CloudKit
   - Multi-device access
   - Automatic backup
   - Collaboration

4. **Security**: Add encryption
   - Protect sensitive data
   - Secure document storage
   - User authentication

## Need Help?

### Resources
- **Xcode Help**: Help > Xcode Help
- **Apple Developer**: developer.apple.com
- **SwiftUI Tutorial**: developer.apple.com/tutorials/swiftui

### Common Issues
- **Simulator slow?** Restart it or use a physical device
- **Build errors?** Clean and rebuild (Shift+Cmd+K, then Cmd+B)
- **App not installing?** Delete old version from device first

## Success Checklist

Before considering the app "ready":

- [ ] App builds without errors
- [ ] App launches successfully
- [ ] Can create all 10 document types
- [ ] Required field validation works
- [ ] Can export to all 3 formats
- [ ] Share functionality works
- [ ] Documents persist after app restart
- [ ] Works on both iPhone and iPad
- [ ] Tested in dark mode
- [ ] No crashes during normal use

## What's Next?

Once the app is running:

1. **Test thoroughly** with real data
2. **Customize templates** for your needs
3. **Add your branding** (colors, logo)
4. **Consider enhancements** (signatures, cloud sync)
5. **Deploy to TestFlight** for beta testing
6. **Submit to App Store** when ready

---

**You're all set!** 🚀

Open `LegalDocGenerator.xcodeproj` in Xcode and press ▶️ to build!

