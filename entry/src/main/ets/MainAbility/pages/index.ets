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
import { MButton, ButtonVariant, ToggleButton } from "@ohos/Material_Button"

@Entry
@Component
struct Index {
  build() {
    Column() {
      Text("Material Contained")
        .fontSize(18)
        .fontColor(Color.Green)
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 10, top: 20 })
      MButton(
        {
          variant: ButtonVariant.CONTAINED,
          content: "BUTTON",
          fontSize: 24,
          fontColor: Color.Black,
          width: 200,
          backgroundColor: Color.Orange,
          elevation: 1,
          cbOnClick: this.buttonClicked
        })
      Text("Material Outlined")
        .fontSize(18)
        .fontColor(Color.Green)
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 10, top: 20 })
      MButton({
        variant: ButtonVariant.OUTLINED,
        content: "BUTTON",
        fontSize: 24,
        fontColor: Color.Blue,
        width: 200,
        rippleColor: Color.Yellow
      })
      Text("Material Text")
        .fontSize(18)
        .fontColor(Color.Green)
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 10, top: 20 })
      MButton({
        variant: ButtonVariant.TEXT,
        content: "BUTTON",
        fontSize: 24,
        fontColor: Color.Black
      })
      Text("Material Outlined (with Icon)")
        .fontSize(18)
        .fontColor(Color.Green)
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 10, top: 20 })
      MButton({
        variant: ButtonVariant.OUTLINED,
        content: "BUTTON",
        iconSrc: $r('app.media.icon'),
        fontSize: 24,
        fontColor: Color.Blue,
        width: 200
      })
      Text("Material Toggle Button (Text)").fontSize(18).fontColor(Color.Green).alignSelf(ItemAlign.Start).margin({bottom:10, top: 20})
      ToggleButton({
        data:[{content: "T1", checked:false, enable: true}, {content:"T2", checked:false, enable:false}, {content: "T3", checked:false}],
        backgroundColor: Color.White,
        selectedBackgroundColor:Color.Yellow,
        width:60,
        height:60,
        toggleBorderWidth:2,
        fontColor:Color.Black,
        cbSelectionOnClick: this.toggleIndexSelected
      })
      Text("Material Toggle Button (Icon)").fontSize(18).fontColor(Color.Green).alignSelf(ItemAlign.Start).margin({bottom:10, top: 20})
      ToggleButton({
        data:[{iconSrc: $r('app.media.icon'), checked:false, enable:true}, {iconSrc: $r('app.media.icon'), checked:false, enable:true}],
        backgroundColor: Color.White,
        selectedBackgroundColor:Color.Yellow,
        width:60,
        height:60,
        cbSelectionOnClick: (checkedIndexes) => {
          this.toggleIndexSelected(checkedIndexes)
        }
      })
    }
    .width('100%')
  }

  buttonClicked() {
    prompt.showToast({
      message: "Button clicked"
    })
  }

  toggleIndexSelected(checkedIndexes: number[]) {
    prompt.showToast({
      message: "Toggle Button Selected Index " + checkedIndexes[0]
    })
  }
}