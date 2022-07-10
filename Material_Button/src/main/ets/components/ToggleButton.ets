import { ButtonModel } from './ButtonModel';
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
import { ToggleButtonOptions} from "./Types"

@Component
export struct ToggleButton {
  private options: ToggleButtonOptions = undefined

  @State model: ToggleButtonModel = undefined
  private getModel: (ToggleButtonModel) => void = undefined
  private buttonModelList : ButtonModel[] = []
  private onToggleSelection: (checkedIndexes: number[]) => void = undefined;

  aboutToAppear() {
    if (this.model == undefined) {
      this.model = new ToggleButtonModel(this.options)
    }
    if (this.getModel) {
      this.getModel(this.model)
    }
  }

  build() {
    RowSplit() {
      ForEach(this.model.buttonModelList, (item, index) => {
        MButton({ model: item,
          getModel: (model) => this.getButtonModel(model),
          clickCallBack: {
            responseCode: index,
            callback: (event, selectionIndex) => this.onClickGroup(selectionIndex)
          }
        })
      })
    }
    .height(this.model.height + (this.model.toggleBorderWidth * 2))
    .padding(this.model.toggleBorderWidth)
    .backgroundColor(this.model.toggleBorderColor)
  }

  getButtonModel(model) {
    this.buttonModelList.push(model)
    this.model.buttonModelList[this.buttonModelList.length-1] = model
  }

  onClickGroup(selectionIndex: number): void {
    if (this.model.buttonModelList[selectionIndex].opacity == 1) {
      this.model.checkOrUncheck(selectionIndex)
      if (this.onToggleSelection) {
        this.onToggleSelection(this.model.getCheckedIndexes())
      }
    }
  }
}

