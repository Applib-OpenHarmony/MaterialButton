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

import { ToggleButtonOptions, ToggleSelection, ButtonVariant, ButtonOptions, TextualToggleType, IconToggleType } from "./Types"
import { ButtonModel } from "./ButtonModel"

export class ToggleButtonModel implements ToggleButtonOptions{
  data: TextualToggleType[] | IconToggleType[] = []
  width: number = 40
  height: number = 40
  selectionType: ToggleSelection = ToggleSelection.Single
  toggleBorderWidth: number = 2
  selectedBorderWidth: number = 2
  backgroundColor: ResourceColor = Color.White
  toggleBorderColor: ResourceColor = Color.Grey
  toggleBorderRadius: number = undefined
  selectedBackgroundColor: ResourceColor = "#D3D3D3"
  fontColor: ResourceColor = Color.White
  fontSize: number = 20
  checkedVariant: ButtonVariant = ButtonVariant.TEXT
  checkedBackgroundColor: ResourceColor = undefined
  toggleButtonModel: ToggleButtonModel = undefined
  buttonModelList: ButtonModel[] = []
  buttonSelStatus: boolean[] = []

  constructor(inputOptions: ToggleButtonOptions) {
    this.update(inputOptions)
    let buttonOptions: ButtonOptions = undefined
    this.data.forEach((entry, index) => {
      buttonOptions = undefined
      if ('content' in entry) {
        let opacity = 1
        if (typeof entry.enable == 'boolean' && !entry.enable) {
          opacity = 0.38
        }
        buttonOptions = {
          variant: ButtonVariant.TEXT,
          content: entry.content,
          responseCode: index,
          backgroundColor: this.backgroundColor,
          height: this.height,
          width: this.width,
          opacity: opacity,
          ripple:false
        }
      } else {
        let opacity = 1
        if (typeof entry.enable == 'boolean' && !entry.enable) {
          opacity = 0.38
        }
        buttonOptions = {
          variant: ButtonVariant.TEXT,
          iconSrc: entry.iconSrc,
          responseCode: index,
          height: this.height,
          width: this.width,
          backgroundColor: this.backgroundColor,
          opacity:opacity,
          ripple:false
        }
      }
      if (index > 0) {
        buttonOptions['margin'] = {left: this.toggleBorderWidth}
      }
      let bm = new ButtonModel(buttonOptions)
      bm.update(inputOptions)
      this.buttonModelList.push(bm)
      this.buttonSelStatus.push(false)
      if (entry.checked) {
        this.checkOrUncheck(index)
      }
    })
  }

  update(options: ToggleButtonOptions) {
    if (options) {
      if (options.data != undefined) this.data = options.data
      if (options.selectionType != undefined) this.selectionType = options.selectionType
      if (options.selectedBorderWidth != undefined) this.selectedBorderWidth = options.selectedBorderWidth
      if (options.toggleBorderWidth != undefined) this.toggleBorderWidth = options.toggleBorderWidth
      if (options.backgroundColor != undefined) this.backgroundColor = options.backgroundColor
      if (options.fontColor != undefined) this.fontColor = options.fontColor
      if (options.fontSize != undefined) this.fontSize = options.fontSize
      if (options.width != undefined) this.width = options.width
      if (options.height != undefined) this.height = options.height
      if (options.checkedVariant != undefined) this.checkedVariant = options.checkedVariant
      if (options.checkedBackgroundColor != undefined) this.checkedBackgroundColor = options.checkedBackgroundColor
      if (options.selectedBackgroundColor != undefined) this.selectedBackgroundColor = options.selectedBackgroundColor
      if (options.toggleBorderColor != undefined) this.toggleBorderColor = options.toggleBorderColor
      if (options.toggleBorderRadius != undefined) this.toggleBorderRadius = options.toggleBorderRadius
    }
  }

  checkOrUncheck(sel: number) {
    this.unCheckAll(sel)
    if (this.buttonSelStatus[sel]) {
      this.buttonSelStatus[sel] = false
      this.buttonModelList[sel].backgroundColor = this.backgroundColor
    } else {
      this.buttonSelStatus[sel] = true
      this.buttonModelList[sel].backgroundColor = this.selectedBackgroundColor
    }
  }

  unCheckAll(exceptIndex: number) {
    this.buttonModelList.forEach((btnModel, index) => {
      if (index != exceptIndex) {
        this.buttonSelStatus[index] = false
        btnModel.backgroundColor = this.backgroundColor
      }
    })
  }

  getCheckedIndexes(): number[] {
    var checkedList: number[] = []
    this.buttonSelStatus.forEach((isChecked, sel) => {
      if (isChecked) {
        checkedList.push(sel)
      }
    })
    return checkedList
  }
}