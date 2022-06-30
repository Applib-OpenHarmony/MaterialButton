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
 
import { ToggleButtonModel } from "./ToggleButtonModel"
import { MButton } from './Button'
import { ToggleSelection, ButtonVariant, TextualToggleType, IconToggleType } from "./Types"

@Component
export struct ToggleButton {
  @State private updateUI: number = 1
  @State data?: TextualToggleType[] | IconToggleType[] = []
  @State width: number = 40
  @State height: number = 40
  @State selectionType?: ToggleSelection = ToggleSelection.Single
  @State toggleBorderWidth?: number = 2
  @State selectedBorderWidth?: number = 2
  private backgroundColor: ResourceColor = Color.White
  private toggleBorderColor?: ResourceColor = Color.Grey
  @State toggleBorderRadius?: number = undefined
  private selectedBackgroundColor?: ResourceColor = "#D3D3D3"
  private fontColor?: ResourceColor = Color.White
  @State fontSize?: number = 20
  private checkedVariant: ButtonVariant = ButtonVariant.TEXT
  @State checkedBackgroundColor?: ResourceColor = undefined
  @State toggleButtonModel: ToggleButtonModel = undefined
  private cbSelectionOnClick: (checkedIndexes: number[]) => void = undefined;

  aboutToAppear() {
    if (this.toggleButtonModel == undefined) {
      this.toggleButtonModel = new ToggleButtonModel({
        data: this.data,
        width: this.width,
        height: this.height,
        selectionType: this.selectionType,
        toggleBorderWidth: this.toggleBorderWidth,
        selectedBorderWidth: this.selectedBorderWidth,
        backgroundColor: this.backgroundColor,
        toggleBorderColor: this.toggleBorderColor,
        toggleBorderRadius: this.toggleBorderRadius,
        selectedBackgroundColor: this.selectedBackgroundColor,
        fontColor: this.fontColor,
        fontSize: this.fontSize,
        checkedVariant: this.checkedVariant,
        checkedBackgroundColor: this.checkedBackgroundColor
      })
      if (this.toggleButtonModel.options.data != undefined) this.data = this.toggleButtonModel.options.data
      if (this.toggleButtonModel.options.width != undefined) this.width = this.toggleButtonModel.options.width
      if (this.toggleButtonModel.options.height != undefined) this.height = this.toggleButtonModel.options.height
      if (this.toggleButtonModel.options.selectionType != undefined) this.selectionType = this.toggleButtonModel.options.selectionType
      if (this.toggleButtonModel.options.toggleBorderWidth != undefined) this.toggleBorderWidth = this.toggleButtonModel.options.toggleBorderWidth
      if (this.toggleButtonModel.options.selectedBorderWidth != undefined) this.selectedBorderWidth = this.toggleButtonModel.options.selectedBorderWidth
      if (this.toggleButtonModel.options.backgroundColor != undefined) this.backgroundColor = this.toggleButtonModel.options.backgroundColor
      if (this.toggleButtonModel.options.toggleBorderColor != undefined) this.toggleBorderColor = this.toggleButtonModel.options.toggleBorderColor
      if (this.toggleButtonModel.options.toggleBorderRadius != undefined) this.toggleBorderRadius = this.toggleButtonModel.options.toggleBorderRadius
      if (this.toggleButtonModel.options.selectedBackgroundColor != undefined) this.selectedBackgroundColor = this.toggleButtonModel.options.selectedBackgroundColor
      if (this.toggleButtonModel.options.fontColor != undefined) this.fontColor = this.toggleButtonModel.options.fontColor
      if (this.toggleButtonModel.options.fontSize != undefined) this.fontSize = this.toggleButtonModel.options.fontSize
      if (this.toggleButtonModel.options.checkedVariant != undefined) this.checkedVariant = this.toggleButtonModel.options.checkedVariant
      if (this.toggleButtonModel.options.checkedBackgroundColor != undefined) this.checkedBackgroundColor = this.toggleButtonModel.options.checkedBackgroundColor
    }
  }

  build() {
    if (this.updateUI > 0) {
      RowSplit() {
        ForEach(this.toggleButtonModel.buttonModelList, (item) => {
          MButton({ buttonModel: item,
            backgroundColor: item.options.backgroundColor,
            cbOnClick: (event, selectionIndex) => {
              this.updateUI += 1
              this.onClickGroup(selectionIndex)
            }
          })
        })
      }
      .height(this.height + (this.toggleBorderWidth * 2))
      .padding(this.toggleBorderWidth)
      .backgroundColor(this.toggleBorderColor)
    }
  }

  onClickGroup(selectionIndex: number): void {
    this.updateUI += 1
    if (this.toggleButtonModel.buttonModelList[selectionIndex].options.opacity == 1) {
      this.toggleButtonModel.checkOrUncheck(selectionIndex)
      if (this.cbSelectionOnClick) {
        this.cbSelectionOnClick(this.toggleButtonModel.getCheckedIndexes())
      }
    }
  }
}

