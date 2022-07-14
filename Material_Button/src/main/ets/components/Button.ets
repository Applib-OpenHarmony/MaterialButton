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

import { ButtonOptions } from "./Types"
import { ButtonModel } from './ButtonModel'
import { rippleUtils } from './Ripple'

@Component
export struct MButton {
  private options: ButtonOptions = undefined
  private clickCallBack: {
    responseCode?: number,
    callback: (event: ClickEvent, responseCode?: number) => void
  }
  @State model: ButtonModel = undefined
  private getModel: (ButtonModel) => void = undefined
  @State iconHeight: number = 30
  @State containerSize: SizeOptions = {}
  @State clickCoordinates: Position = { x: 0, y: 0 } // click event coordinates
  @State border: BorderOptions = {}
  @State showRipple: boolean = false

  aboutToAppear() {
    if (this.model == undefined) {
      this.model = new ButtonModel(this.options);
    }
    if (this.getModel) {
      this.getModel(this.model)
    }
  }

  build() {
    Stack() {
      Column()
      Button() {
        Row() {
          if (this.model.iconSrc) {
            Image(this.model.iconSrc)
              .width(this.iconHeight)
              .height(this.iconHeight)
              .margin({ right: this.model.spaceBetweenIconAndText })
              .backgroundColor(this.model.backgroundColor)
          }
          if (this.model.content) {
            Text(this.model.content)
              .fontColor(this.model.fontColor)
              .fontSize(this.model.fontSize)
              .backgroundColor(this.model.backgroundColor)
              .onAreaChange((oldValue, newValue) => {
                if (typeof newValue.height == 'number')
                this.iconHeight = newValue.height
              })
          }
        }.alignItems(VerticalAlign.Center)
        .padding(this.model.padding)
      }
      .zIndex(1)
      .shadow({
        radius: this.model.shadowRadius,
        color: this.model.backgroundColor,
        offsetY: this.model.elevation / 4
      })
      .height(this.model.height)
      .width(this.model.width)
      .type(ButtonType.Normal)
      .borderStyle(this.model.borderStyle)
      .borderWidth(this.model.borderWidth)
      .borderRadius(this.model.borderRadius)
      .borderColor(this.model.borderColor)
      .backgroundColor(this.model.backgroundColor)
      .opacity(this.model.opacity)
      .onAreaChange((oldSize, newSize) => {
        this.containerSize.height = newSize.height
        this.containerSize.width = newSize.width
      })
      .onClick((event) => {
        if (this.model.ripple) {
          this.clickCoordinates = {
            x: event.x,
            y: event.y
          }
          this.showRipple = true
          setTimeout(() => {
            this.onClick(event)
          }, 300)
        } else {
          this.onClick(event)
        }
      })

      rippleUtils({
        size: $containerSize,
        border: $border,
        rippleStartPosition: $clickCoordinates,
        showRipple: $showRipple,
        color: this.model.rippleColor,
      })
    }
    .margin(this.model.margin)
  }

  onClick(event: ClickEvent) {
    if (this.clickCallBack.callback) {
      this.clickCallBack.callback(event, this.clickCallBack.responseCode)
    }
  }
}

