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
 
import { ToggleButtonOptions, ToggleSelection, ButtonVariant, ButtonOptions } from "./Types"
import { ButtonModel } from "./ButtonModel"

export class ToggleButtonModel {
  options: ToggleButtonOptions = {}
  buttonModelList: ButtonModel[] = []
  buttonSelStatus: boolean[] = []

  constructor(inputOptions: ToggleButtonOptions) {
    this.update(inputOptions)
    let buttonOptions: ButtonOptions = undefined
    this.options.data.forEach((entry, index) => {
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
          backgroundColor: this.options.backgroundColor,
          height: this.options.height,
          width: this.options.width,
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
          height: this.options.height,
          width: this.options.width,
          backgroundColor: this.options.backgroundColor,
          opacity:opacity,
          ripple:false
        }
      }
      if (index > 0) {
        buttonOptions['margin'] = {left: this.options.toggleBorderWidth}
      }
      let bm = new ButtonModel(buttonOptions)
      bm.update(this.options)
      this.buttonModelList.push(bm)
      this.buttonSelStatus.push(false)
      if (entry.checked) {
        this.checkOrUncheck(index)
      }
    })
  }

  update(options: ToggleButtonOptions) {
    if (options) {
      if (options.data != undefined) this.options.data = options.data
      if (options.selectionType != undefined) this.options.selectionType = options.selectionType
      if (options.selectedBorderWidth != undefined) this.options.selectedBorderWidth = options.selectedBorderWidth
      if (options.toggleBorderWidth != undefined) this.options.toggleBorderWidth = options.toggleBorderWidth
      if (options.backgroundColor != undefined) this.options.backgroundColor = options.backgroundColor
      if (options.fontColor != undefined) this.options.fontColor = options.fontColor
      if (options.fontSize != undefined) this.options.fontSize = options.fontSize
      if (options.width != undefined) this.options.width = options.width
      if (options.height != undefined) this.options.height = options.height
      if (options.checkedVariant != undefined) this.options.checkedVariant = options.checkedVariant
      if (options.checkedBackgroundColor != undefined) this.options.checkedBackgroundColor = options.checkedBackgroundColor
      if (options.selectedBackgroundColor != undefined) {
        this.options.selectedBackgroundColor = options.selectedBackgroundColor
      }
      if (options.toggleBorderColor != undefined) this.options.toggleBorderColor = options.toggleBorderColor
      if (options.toggleBorderRadius != undefined) this.options.toggleBorderRadius = options.toggleBorderRadius
    }
  }

  checkOrUncheck(sel: number) {
    this.unCheckAll(sel)
    if (this.buttonSelStatus[sel]) {
      this.buttonSelStatus[sel] = false
      this.buttonModelList[sel].options.backgroundColor = this.options.backgroundColor
    } else {
      this.buttonSelStatus[sel] = true
      this.buttonModelList[sel].options.backgroundColor = this.options.selectedBackgroundColor
    }
  }

  unCheckAll(exceptIndex: number) {
    this.buttonModelList.forEach((btnModel, index) => {
      if (index != exceptIndex) {
        this.buttonSelStatus[index] = false
        btnModel.options.backgroundColor = this.options.backgroundColor
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