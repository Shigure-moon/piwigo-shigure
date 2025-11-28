# Super Zoom Plugin for Piwigo

A high-quality image zoom plugin for Piwigo that allows users to view images at full resolution with smooth zoom and pan capabilities.

## Features

- **Full Resolution Display**: Images display at original resolution or larger by default
- **Smooth Zoom**: Mouse wheel zoom with smooth animations
- **Pan & Drag**: Click and drag to navigate zoomed images
- **Zoom Controls**: Buttons to zoom in/out
- **Modal View**: Full-screen modal dialog for immersive viewing
- **Touch Support**: Works on touch devices

## Installation

1. Copy the `super_zoom` folder to your Piwigo `plugins` directory
2. Go to Administration > Plugins
3. Activate the "Super Zoom" plugin

## Usage

Once activated, a zoom icon will appear on picture pages. Click it to open the image in full-screen zoom mode.

- **Mouse Wheel**: Zoom in/out
- **Click & Drag**: Pan around the zoomed image
- **Zoom Buttons**: Use the +/- buttons to control zoom level
- **Close Button**: Click X to close the zoom view

## Technical Details

- Uses WZoom library for smooth zoom functionality
- Supports JPEG, PNG, and WebP images
- Automatically uses original image resolution
- Responsive design works on all screen sizes

## License

This plugin is free software licensed under the GNU General Public License.

## Changelog

### Modified Version
- Images now display at original resolution or larger by default
- Improved initial scaling calculation
- Enhanced CSS for better image display
- Better viewport handling

