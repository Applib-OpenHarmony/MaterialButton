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
 
import { ButtonVariant } from "./Types"
import { ButtonModel } from './ButtonModel'
import { rippleUtils } from './Ripple'

@Component
export struct MButton {
  @State variant?: ButtonVariant = ButtonVariant.TEXT
  @State responseCode?: number = undefined
  @State content?: string = undefined
  private iconSrc?: string | PixelMap | Resource = undefined
  @State borderStyle?: BorderStyle = undefined
  @State borderWidth?: number = undefined
  @State borderRadius: number = undefined
  private backgroundColor?: ResourceColor = undefined
  private fontColor?: ResourceColor = undefined
  private borderColor?: ResourceColor = undefined
  @State fontSize?: number = 20
  @State width?: number = undefined
  @State height?: number = undefined
  private margin?: Margin | Length = undefined
  private padding?: Padding | Length = undefined
  @State elevation?: number = undefined
  @State ripple: boolean = true
  @State showRipple: boolean = false
  @State rippleColor?: ResourceColor = Color.White
  @State opacity?: number = 1
  @State buttonModel: ButtonModel = undefined
  private cbOnClick: (event: ClickEvent, responseCode?: number) => void = undefined;
  @State iconHeight: number = 30
  @State private containerSize: SizeOptions = {}
  @State border: BorderOptions = {}  // set custom border config
  @State private clickCoordinates: Position = { x: 0, y: 0 } // click event coordinates

  aboutToAppear() {
    if (this.buttonModel == undefined) {
      this.buttonModel = new ButtonModel({
        variant: this.variant,
        responseCode: this.responseCode,
        content: this.content,
        iconSrc: this.iconSrc,
        borderStyle: this.borderStyle,
        borderWidth: this.borderWidth,
        borderRadius: this.borderRadius,
        backgroundColor: this.backgroundColor,
        fontColor: this.fontColor,
        borderColor: this.borderColor,
        fontSize: this.fontSize,
        width: this.width,
        height: this.height,
        margin: this.margin,
        padding: this.padding,
        elevation: this.elevation,
        ripple: this.ripple,
        rippleColor: this.rippleColor,
        opacity: this.opacity
      });
    }
    if (this.buttonModel.options.variant != undefined) this.variant = this.buttonModel.options.variant
    if (this.buttonModel.options.responseCode != undefined) this.responseCode = this.buttonModel.options.responseCode
    if (this.buttonModel.options.content != undefined) this.content = this.buttonModel.options.content
    if (this.buttonModel.options.iconSrc != undefined) this.iconSrc = this.buttonModel.options.iconSrc
    if (this.buttonModel.options.borderStyle != undefined) this.borderStyle = this.buttonModel.options.borderStyle
    if (this.buttonModel.options.borderWidth != undefined) this.borderWidth = this.buttonModel.options.borderWidth
    if (this.buttonModel.options.borderRadius != undefined) this.borderRadius = this.buttonModel.options.borderRadius
    if (this.buttonModel.options.backgroundColor != undefined) this.backgroundColor = this.buttonModel.options.backgroundColor
    if (this.buttonModel.options.fontColor != undefined) this.fontColor = this.buttonModel.options.fontColor
    if (this.buttonModel.options.borderColor != undefined) this.borderColor = this.buttonModel.options.borderColor
    if (this.buttonModel.options.fontSize != undefined) this.fontSize = this.buttonModel.options.fontSize
    if (this.buttonModel.options.width != undefined) this.width = this.buttonModel.options.width
    if (this.buttonModel.options.height != undefined) this.height = this.buttonModel.options.height
    if (this.buttonModel.options.margin != undefined) this.margin = this.buttonModel.options.margin
    if (this.buttonModel.options.padding != undefined) this.padding = this.buttonModel.options.padding
    if (this.buttonModel.options.elevation != undefined) this.elevation = this.buttonModel.options.elevation
    if (this.buttonModel.options.ripple != undefined) this.ripple = this.buttonModel.options.ripple
    if (this.buttonModel.options.rippleColor != undefined) this.rippleColor = this.buttonModel.options.rippleColor
    if (this.buttonModel.options.opacity != undefined) this.opacity = this.buttonModel.options.opacity
    if (this.buttonModel.options.borderRadius != undefined) this.border.radius = this.buttonModel.options.borderRadius
  }

  build() {
    Stack() {
      Button() {
        Row() {
          if (this.iconSrc) {
            Image(this.iconSrc)
              .width(this.iconHeight)
              .height(this.iconHeight)
              .margin({ right: this.buttonModel.spaceBetweenIconAndText })
              .backgroundColor(this.backgroundColor)
          }
          if (this.content) {
            Text(this.content)
              .fontColor(this.fontColor)
              .fontSize(this.fontSize)
              .backgroundColor(this.backgroundColor)
              .onAreaChange((oldValue, newValue) => {
                if (typeof newValue.height == 'number')
                this.iconHeight = newValue.height
              })
          }
        }.alignItems(VerticalAlign.Center)
        .padding(this.padding)
      }
      .zIndex(1)
      .shadow({
        radius: this.buttonModel.shadowRadius,
        color: this.backgroundColor,
        offsetY: this.elevation/4
      })
      .height(this.height)
      .width(this.width)
      .type(ButtonType.Normal)
      .borderStyle(this.borderStyle)
      .borderWidth(this.borderWidth)
      .borderRadius(this.borderRadius)
      .borderColor(this.borderColor)
      .backgroundColor(this.backgroundColor)
      .opacity(this.opacity)
      .onAreaChange((oldSize, newSize) => {
        this.containerSize.height = newSize.height
        this.containerSize.width = newSize.width
      })
      .onClick((event) => {
        if (this.ripple) {
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
        color: this.rippleColor,
      })
    }
    .margin(this.margin)
  }

  onClick(event: ClickEvent) {
    if (this.cbOnClick) {
      this.cbOnClick(event, this.responseCode)
    }
  }
}

