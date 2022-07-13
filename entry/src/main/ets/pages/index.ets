/*
 * Copyright (C) 2020-21 Application Library Engineering Group
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import prompt from '@system.prompt'
import { MButton, ButtonVariant, ButtonModel, ToggleButton } from "@ohos/material-button"

@Entry
@Component
struct Index {
  private model: ButtonModel = undefined

  build() {
    Column() {
      Text("Material Contained")
        .fontSize("18fp")
        .fontColor(Color.Green)
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 10vp, top: 20 })
      MButton(
        {
          options: {
            variant: ButtonVariant.CONTAINED,
            content: "BUTTON",
            fontSize: "24fp",
            ripple: true,
            rippleColor: Color.White,
            fontColor: Color.Black,
            width: 200,
            backgroundColor: Color.Orange,
            elevation: 1
          },
          clickCallBack: {
            responseCode: 1,
            callback: this.buttonClicked
          }
        })
      Text("Material Outlined")
        .fontSize("18fp")
        .fontColor(Color.Green)
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 10, top: 20 })
      MButton(
        { options: {
          variant: ButtonVariant.OUTLINED,
          content: "BUTTON",
          fontSize: "24fp",
          fontColor: Color.Blue,
          width: 200,
          rippleColor: Color.Yellow
        },
          clickCallBack: {
            responseCode: 2,
            callback: this.buttonClicked
          }
        })
      Text("Material Text")
        .fontSize("18fp")
        .fontColor(Color.Green)
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 10, top: 20 })
      MButton(
        { options: {
          variant: ButtonVariant.TEXT,
          content: "BUTTON",
          fontSize: "24fp",
          fontColor: Color.Black
        },
          clickCallBack: {
            responseCode: 3,
            callback: this.buttonClicked
          }
        })
      Text("Material Outlined (with Icon)")
        .fontSize("18fp")
        .fontColor(Color.Green)
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 10, top: 20 })
      MButton({
        options: {
          variant: ButtonVariant.OUTLINED,
          content: "BUTTON",
          iconSrc: $r('app.media.icon'),
          fontSize: "24fp",
          fontColor: Color.Blue,
          width: 200
        },
        getModel: (model) => this.getButtonModel(model),
        clickCallBack: {
          responseCode: 4,
          callback: (event, responseCode) => this.buttonClicked(event, responseCode)
        }
      })
      Text("Material Toggle Button (Text)")
        .fontSize("18fp")
        .fontColor(Color.Green)
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 10, top: 20 })
      ToggleButton({
        options: {
          data: [{ content: "T1", checked: false, enable: true }, { content: "T2", checked: false, enable: false }, {
            content: "T3",
            checked: false
          }],
          backgroundColor: Color.White,
          selectedBackgroundColor: Color.Yellow,
          width: 60,
          height: 60,
          toggleBorderWidth: 2,
          fontColor: Color.Black
        },
        onToggleSelection: (checkedIndexes: number[]) => this.toggleIndexSelected(checkedIndexes)
      })
      Text("Material Toggle Button (Icon)")
        .fontSize("18fp")
        .fontColor(Color.Green)
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 10, top: 20 })
      ToggleButton({
        options: {
          data: [{ iconSrc: $r('app.media.icon'), checked: false, enable: true }, {
            iconSrc: $r('app.media.icon'),
            checked: false,
            enable: true
          }],
          backgroundColor: Color.White,
          selectedBackgroundColor: Color.Yellow,
          width: 60,
          height: 60
        },
        onToggleSelection: (checkedIndexes: number[]) => this.toggleIndexSelected(checkedIndexes)
      })
    }
    .width('100%')
  }

  getButtonModel(model: ButtonModel) {
    this.model = model
  }

  buttonClicked(event, responseCode) {
    if (this.model) {
      this.model.fontColor = Color.Black
    }
    prompt.showToast({
      message: "Button clicked " + responseCode
    })
  }

  toggleIndexSelected(checkedIndexes: number[]) {
    prompt.showToast({
      message: "Toggle Button Selected Index " + checkedIndexes[0]
    })
  }
}