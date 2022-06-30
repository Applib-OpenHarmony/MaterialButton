# material button

## Introduction

Material component design of Button for OpenHarmony.

## Screenshots

![](screenshots/button1.jpg) ![](screenshots/button2.jpg)

# Adding Dependencies:

For using material button in your app, add the below dependency in entry/package.json

```
"dependencies": {
"mdc_button": "file:../button"
}
```

## Usage Instructions

##### 1. Adding Material Contained button to the application, Material button is implemented as "MButton" component

```javascript
import {MButton, ButtonVariant, ButtonOptions} from "mdc_button"

@Component
struct Index {
  private buttonContained : ButtonOptions = {
  variant: ButtonVariant.CONTAINED, //Select Button Type TEXT/OUTLINED/CONTAINED
  content : "BUTTON",
  fontSize:24,
  fontColor: Color.Blue,
  width:200,
  backgroundColor:Color.Orange,
  elevation:1,
  rippleColor: Color.Black
  }

  build() {
    Column() {
      MButton({options: this.buttonContained, cbOnClick: this.buttonClicked})
    }
  }

  buttonClicked() {
    prompt.showToast({message: "Button clicked"})
  }
}
```
##### 2. Adding Material Toggle button to the application
```javascript
import {ToggleButton, ButtonOptions, ToggleButtonOptions} from "mdc_button"
@Component
struct Index {
  private toggleButtonText : ToggleButtonOptions = {
    data:[{value: "T1", checked:true}, {value:"T2", checked:false}, {value: "T3", checked:false}],
    backgroundColor: Color.White,
    width:60,
    borderWidth: 1,
    height:60}
    build() {
      Column() {
        ToggleButton({ options: this.toggleButtonText, cbSelectionOnClick: this.toggleIndexSelected})
      }
    }
    
    toggleIndexSelected(checkedIndexes: number[]) {
      prompt.showToast({message: "Toggle Button Selected Index " + checkedIndexes[0]})
    }
}
```

### Attributes
#### Button Options

| Attribute | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `variant` | `ButtonVariant` | Select Variant TEXT, OUTLINED, CONTAINED |
| `clickCallback` | `(event: ClickEvent, responseCode: number) => void` | Callback to set to listen ClickEvent |
| `responseCode` | `number` | Response code set during call back is returned same during call back |
| `content` | `string` | button text |
| `iconSrc` | `string or PixelMap or Resource` | icon path |
| `borderStyle` | `BorderStyle` | border style |
| `borderWidth` | `number` | border width |
| `borderRadius` | `Length` | border radius |
| `backgroundColor` | `ResourceColor` | background color |
| `fontColor` | `ResourceColor` | font color |
| `borderColor` | `ResourceColor` | border color |
| `fontSize` | `Length` | font size |
| `width` | `Length` | width |
| `height` | `Length` | height |
| `margin` | `Margin or Length` | margin |
| `padding` | `Padding or Length` | padding |
| `elevation` | `number` | elevation |
| `rippleColor` | `ResourceColor` | Ripple color |

#### Toggle Button Options

| Attribute | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `data` | `TextualToggleType[] or IconToggleType[]` | List of Text or Icon buttons |
| `width` | `Length` | width of each button |
| `height` | `Length` | height of each button |
| `cbSelectionOnClick` | `(checkedIndexes: number[]) => void` | call back with selected index |
| `toggleBorderWidth` | `number` | toggle Border width |
| `borderWidth` | `number` | border width |
| `backgroundColor` | `ResourceColor` | background color |
| `selectedBackgroundColor` | `ResourceColor` | selected background color |
| `fontColor` | `ResourceColor` | font color |
| `fontSize` | `Length` | font size |
| `checkedVariant` | `ButtonVariant` | selected button variant |
| `checkedBackgroundColor` | `ResourceColor` | selected background color |

## Contribution Code
Any questions found during the use process can be submitted to us by [Issue](https://github.com/Applib-OpenHarmony/MaterialButton/issues). Of course, we welcome you to send us [PR](https://github.com/Applib-OpenHarmony/MaterialButton/pulls).

## Open Source Protocol
This project is based on [Apache License 2.0](https://github.com/Applib-OpenHarmony/MaterialButton/blob/main/LICENSE.txt). Please enjoy and participate freely in open source.
