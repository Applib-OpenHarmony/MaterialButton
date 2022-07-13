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

import { ButtonVariant, ButtonOptions } from "./Types"

export const MaterialSpacing = {
  TEXT_ICON_BUTTON_PADDING_LEFT: 12,
  TEXT_BUTTON_PADDING_RIGHT: 16,
  TEXT_BUTTON_PADDING_LEFT: 16,
  CONTAINED_BUTTON_PADDING_LEFT: 24,
  CONTAINED_ICON_BUTTON_PADDING_LEFT: 16,
  CONTAINED_BUTTON_PADDING_RIGHT: 24,
  TEXT_ICON_BUTTON_SPACING: 8
}

export class ButtonModel implements ButtonOptions {
  variant: ButtonVariant = ButtonVariant.TEXT
  content: string = undefined
  iconSrc: string | PixelMap | Resource = undefined
  borderStyle: BorderStyle = undefined
  borderWidth: number = undefined
  borderRadius: number = undefined
  backgroundColor: ResourceColor = undefined
  fontColor: ResourceColor = undefined
  borderColor: ResourceColor = undefined
  fontSize: number | string | Resource = "20fp"
  width: number = undefined
  height: number = undefined
  margin: Margin | Length = undefined
  padding: Padding | Length = undefined
  elevation: number = undefined
  ripple: boolean = true
  showRipple: boolean = false
  rippleColor: ResourceColor = Color.White
  opacity: number = 1
  responseCode: number = undefined

  public shadowRadius = 0;
  public spaceBetweenIconAndText = 0

  constructor(options: ButtonOptions) {
    if (options) {
      let defaultSet: ButtonOptions = {}
      let hasIconNText = false
      if (options.content && options.iconSrc) {
        hasIconNText = true
        this.spaceBetweenIconAndText = 8
      }
      switch (options.variant) {
        case ButtonVariant.TEXT:
          defaultSet['backgroundColor'] = Color.White
          defaultSet['height'] = 40
          if (hasIconNText) {
            defaultSet['padding'] = {
              left: MaterialSpacing.TEXT_ICON_BUTTON_PADDING_LEFT,
              right: MaterialSpacing.TEXT_BUTTON_PADDING_RIGHT
            }
          } else {
            defaultSet['padding'] = {
              left: MaterialSpacing.TEXT_BUTTON_PADDING_LEFT,
              right: MaterialSpacing.TEXT_BUTTON_PADDING_RIGHT
            }
          }
          break;
        case ButtonVariant.CONTAINED:
          if (options.borderRadius) {
            defaultSet['borderRadius'] = options.borderRadius
          } else {
            defaultSet['borderRadius'] = 25
          }
          if (options.elevation) {
            this.shadowRadius = defaultSet['borderRadius'] + options.elevation - 18
            defaultSet['elevation'] = options.elevation
          }
          defaultSet['height'] = 40
          if (hasIconNText) {
            defaultSet['padding'] = {
              left: MaterialSpacing.CONTAINED_ICON_BUTTON_PADDING_LEFT,
              right: MaterialSpacing.TEXT_BUTTON_PADDING_RIGHT
            }
          } else {
            defaultSet['padding'] = {
              left: MaterialSpacing.CONTAINED_BUTTON_PADDING_LEFT,
              right: MaterialSpacing.CONTAINED_BUTTON_PADDING_RIGHT
            }
          }
          break;
        case ButtonVariant.OUTLINED:
          defaultSet['borderStyle'] = BorderStyle.Solid
          defaultSet['borderWidth'] = 2
          defaultSet['borderRadius'] = 25
          defaultSet['backgroundColor'] = Color.White
          defaultSet['height'] = 40
          if (hasIconNText) {
            defaultSet['padding'] = {
              left: MaterialSpacing.CONTAINED_ICON_BUTTON_PADDING_LEFT,
              right: MaterialSpacing.TEXT_BUTTON_PADDING_RIGHT
            }
          } else {
            defaultSet['padding'] = {
              left: MaterialSpacing.CONTAINED_BUTTON_PADDING_LEFT,
              right: MaterialSpacing.CONTAINED_BUTTON_PADDING_RIGHT
            }
          }
          break;
      }
      this.update(defaultSet)
    }
    this.update(options)
  }

  public update(options: ButtonOptions) {
    if (options) {
      if (options.variant != undefined) this.variant = options.variant
      if (options.content != undefined) this.content = options.content
      if (options.iconSrc != undefined) this.iconSrc = options.iconSrc
      if (options.borderStyle != undefined) this.borderStyle = options.borderStyle
      if (options.borderWidth != undefined) this.borderWidth = options.borderWidth
      if (options.borderRadius != undefined) this.borderRadius = options.borderRadius
      if (options.backgroundColor != undefined) this.backgroundColor = options.backgroundColor
      if (options.fontColor != undefined) this.fontColor = options.fontColor
      if (options.fontSize != undefined) this.fontSize = options.fontSize
      if (options.width != undefined) this.width = options.width
      if (options.height != undefined) this.height = options.height
      if (options.responseCode != undefined) this.responseCode = options.responseCode
      if (options.margin != undefined) this.margin = options.margin
      if (options.padding != undefined) this.padding = options.padding
      if (options.ripple != undefined) this.ripple = options.ripple
      if (options.rippleColor != undefined) this.rippleColor = options.rippleColor
      if (options.opacity != undefined) this.opacity = options.opacity
    }
  }

  public setFontColor(color: ResourceColor) {
    this.fontColor = color
  }
}