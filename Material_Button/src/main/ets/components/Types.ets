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
 
export enum ButtonVariant {
  TEXT = 1,
  CONTAINED,
  OUTLINED
}

export enum ToggleVariant {
  ICON_ONLY = 0,
  TEXTUAL_ONLY
}

export enum ToggleSelection {
  Single = 0
}

export type TextualToggleType = {
  content: string
  checked?: boolean
  enable?: boolean
}

export type IconToggleType = {
  iconSrc: string | PixelMap | Resource
  checked: boolean
  enable?: boolean
}

export type ToggleButtonOptions = {
  data?: TextualToggleType[] | IconToggleType[]
  width?: number
  height?: number
  cbSelectionOnClick? : (checkedIndexes: number[]) => void
  selectionType?: ToggleSelection
  toggleBorderWidth?: number
  selectedBorderWidth?: number
  backgroundColor?: ResourceColor
  toggleBorderColor?: ResourceColor
  toggleBorderRadius?: number
  selectedBackgroundColor?: ResourceColor
  fontColor?: ResourceColor
  fontSize?: number
  checkedVariant? : ButtonVariant
  checkedBackgroundColor? : ResourceColor
}

export type ButtonOptions = {
  variant? : ButtonVariant
  responseCode? : number
  content? : string
  iconSrc? : string | PixelMap | Resource
  borderStyle?: BorderStyle
  borderWidth?: number
  borderRadius?: number
  backgroundColor?: ResourceColor
  fontColor?: ResourceColor
  borderColor?: ResourceColor
  fontSize?: number
  width?: number
  height?: number
  margin?: Margin | Length
  padding?: Padding | Length
  elevation?: number
  ripple?: boolean
  rippleColor?: ResourceColor
  opacity?: number
}
