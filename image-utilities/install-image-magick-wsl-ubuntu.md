# Install ImageMagick on Ubuntu (WSL)

1. **Open Ubuntu**:
   - Launch Ubuntu from your WSL installation as explained in the previous instructions.

2. **Update Package Lists**:
   - Before installing any software, update the package lists:
     ```bash
     sudo apt update
     ```

3. **Install ImageMagick**:
   - To install ImageMagick, run the following command:
     ```bash
     sudo apt install imagemagick
     ```

4. **Verify Installation**:
   - You can check if ImageMagick was installed successfully by running:
     ```bash
     convert -version
     ```

   - You should see the ImageMagick version information displayed.

5. **Usage**:
   - You can now use ImageMagick to manipulate and edit images on your Ubuntu WSL installation.

That's it! You've successfully installed ImageMagick on your Ubuntu WSL. Enjoy using it for image processing and manipulation.
