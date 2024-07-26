import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts

// Window type for simple GUI
Window {
    // Set id
    id: window

    // Make it visible
    visible: true

    // Set up geometry
    width: Screen.width / 1.3
    height: Screen.height / 1.3

    // Set the title of window
    title: "Emagick"

    // Container for image
    Item {
        id: imageItem

        width: window.width / 1.5
        height: window.height / 1.5

        // Center the item
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -55

        // Column for Image
        Column {
            width: parent.width

            // Space between text and image
            spacing: 3

            Text {
                text: "IMAGE NAME + RESOLUTION HERE"
                font.italic: true
                color: "blue"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Image {
                id: mainImage
                fillMode: Image.PreserveAspectFit

                anchors.horizontalCenter: parent.horizontalCenter

                // Set width and height
                width: window.width / 1.5
                height: window.height / 1.5

                // Initialize with empty source
                source: ""
            }
        }
    }

    // Container for Open/Save Image button
    Item {
        id: openCloseItem
        width: parent.width

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 25
        anchors.top: parent.top

        RowLayout {
            width: parent.width
            spacing: 20

            // Fill the width of row
            Item {
                Layout.fillWidth: true
            }

            // Set up Open Image button
            Button {
                id: openImage
                text: "Open Image"

                onClicked: openFile.open()
            }

            // Set up Save Image button
            Button {
                id: saveImage
                text: "Save Image"

                onClicked: saveFile.open()
            }

            // Fill the width of row
            Item {
                Layout.fillWidth: true
            }
        }
    }


    // Container for:
    // Normalize, Grayscale, Negate, Despeckle, Equalize,
    // Erase, Flip, Flop, Magnify, Minify, Trim
    Item {
        id: operationsItem1

        // Anchors for setting margin
        anchors.left: parent.left
        anchors.top: parent.top

        anchors.leftMargin: 15
        anchors.topMargin: 15

        width: parent.width - imageItem.width

        Column {
            spacing: 5
            width: parent.width

            Button {
                id: normalize
                text: "Normalize Image"

                onClicked: {
                    guiOps.applyNormalization()

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: grayscale
                text: "Grayscale Image"

                onClicked: {
                    guiOps.applyGrayscale()

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: negate
                text: "Negate Colors"

                onClicked: {
                    guiOps.applyNegation()

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: despeckle
                text: "Despeckle Image"

                onClicked: {
                    guiOps.applyDespeckle()

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: equalize
                text: "Equalize Image"

                onClicked: {
                    guiOps.applyEqualization()

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: erase
                text: "Erase Image"

                onClicked: {
                    guiOps.applyErasure()

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: flip
                text: "Flip Image"

                onClicked: {
                    guiOps.applyFlip()

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: flop
                text: "Flop Image"

                onClicked: {
                    guiOps.applyFlop()

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: magnify
                text: "Magnify Image"

                onClicked: {
                    guiOps.applyMagnification()

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: minify
                text: "Minify Image"

                onClicked: {
                    guiOps.applyMinification()

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: trim
                text: "Trim Edges"

                onClicked: {
                    guiOps.applyTrim()

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }


            Slider {
                id: brightnessSlider
                from: 0
                value: 100
                to: 200

                property real brightnessFactor: 100

                snapMode: Slider.SnapAlways
                stepSize: 5

                onMoved: {
                    brightnessSlider.brightnessFactor = value
                }
            }

            Button {
                id: brightness
                text: "Change Brightness"

                onClicked: {
                    guiOps.applyBrightness(brightnessSlider.brightnessFactor)

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Text {
                text: "Brightness Factor: " + brightnessSlider.brightnessFactor
                color: "black"
            }

            ComboBox {
                id: noiseType

                currentIndex: 1

                editable: true
                model: ["Uniform Noise", "Gaussian Noise", "Multiplicative Gaussian Noise", "Impulse Noise", "Laplacian Noise", "Poisson Noise"]
            }

            Button {
                id: noise

                text: "Add noise"

                onClicked: {
                    guiOps.applyNoise(noiseType.currentIndex)

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

        }
    }



    // Set up openFile Dialog
    FileDialog {
        id: openFile
        currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        nameFilters: ["Images (*.jpg *.jpeg *.png *.bmp)", "All Files (*)"]

        onAccepted: {
            // Load the image and set the source directly
            guiOps.loadImage(selectedFile)

            // Update image
            mainImage.source = "data:image/jpeg;base64," + guiOps.getImageData()
        }
    }

    // Set up saveFile Dialog
    FileDialog {
        id: saveFile
        currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]

        fileMode: FileDialog.SaveFile

        nameFilters: ["Images (*.jpeg *.jpg *.png *.bmp)", "All Files (*)"]

        onAccepted: {
            guiOps.saveImage(selectedFile)
        }
    }
}
