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
struct Shopping {
  private AvailableSizes: string[] = ["6 inches", "7 inches", "8 inches", "9 inches"]
  @State private readMore: boolean = false
  @State private descriptionHt: string | number = 148

  build() {
    Column() {
      Flex({ justifyContent: FlexAlign.Center }) {
        Text("<     Detail     >").fontWeight(FontWeight.Bold).fontSize(30).margin({ top: 20, bottom: 5 })
      }
      Image($r('app.media.dress_show1'))
        .border({ width: 1 })
        .borderStyle(BorderStyle.Solid)
        .borderColor(Color.White)
        .objectFit(ImageFit.Contain)
        .width("100%")
        .height("250")
        .margin(15)
      Flex({ direction: FlexDirection.Column }) {
        Text("Running Unisex Shoes").fontSize(24)
        Text("Rs 1400").fontSize(28)
        if (!this.readMore) {
          Text("A pair of black solid round toe formal derbys with regular styling has a lace-up closureSynthetic leather upper Cushioned footbed Textured and patterned rubber outsole Warranty: 3 Months Warranty provided by brand/manufacturer...")
            .fontSize(16)
            .fontColor(Color.Grey)
        } else {
          Text("A pair of black solid round toe formal derbys with regular styling has a lace-up closure Synthetic leather upper Cushioned footbed Textured and patterned rubber outsole Warranty: 3 Months Warranty provided by brand/manufacturer. Material & Care Synthetic leather Allow your pair of shoes to air and deodorize at regular basis Use shoe bags to prevent any stains or mildew Dust any dry dirt from the surface using a clean cloth Do not use polish or shiner. Specification: Type > Derbys, Fastening > Lace-Ups, Toe Shape > Round Toe, Pattern > Solid, Ankle Height > Mid-Top, Sole Material > Rubber, Warranty > 3 months.")
            .fontSize(16)
            .fontColor(Color.Grey)
          Row() {
            MButton({
              variant: ButtonVariant.OUTLINED,
              backgroundColor: Color.White,
              content: "Back",
              borderColor: Color.Grey,
              borderWidth:1,
              fontSize: 20,
              margin: { left: 10 },
              fontColor: Color.Black,
              cbOnClick: () => this.readMoreOpenClose()
            })
            MButton({
              variant: ButtonVariant.CONTAINED,
              backgroundColor: "#D3D3D3",
              content: "Continue",
              fontSize: 20,
              margin: { left: 120 },
              fontColor: Color.Black,
              cbOnClick: () => this.readMoreOpenClose()
            })
          }
          .height(50)
          .width("100%")
          .margin({ top: 15 })
        }
      }.width("100%").height(this.descriptionHt)
      if (!this.readMore) {
        MButton({ content: "read more", fontColor: Color.Black,
          fontSize: 18,
          cbOnClick: () => this.readMoreOpenClose()})
      }
      Text("Available Sizes").fontSize(20).margin({ bottom: 10 })
      ToggleButton({
        data: [{ value: this.AvailableSizes[0], checked: false, enable: true }, {
          value: this.AvailableSizes[1],
          checked: true,
          enable: true
        }, { value: this.AvailableSizes[2], checked: false }, { value: this.AvailableSizes[3], checked: false }],
        backgroundColor: Color.White,
        selectedBackgroundColor: "#FF1493",
        width: 90,
        height: 60,
        fontSize: 13,
        toggleBorderWidth: 1,
        fontColor: Color.Black,
        cbSelectionOnClick: (checkedIndexes) => this.sizeSelect(checkedIndexes)
      })
      Divider().height(60).color(Color.White)
      Flex({ justifyContent: FlexAlign.End }) {
        MButton({
          variant: ButtonVariant.CONTAINED,
          backgroundColor: "#FF1493",
          content: "Add to Cart",
          iconSrc: $r('app.media.shopping_bag'),
          fontSize: 22,
          fontColor: Color.White,
          height: 60,
          width: 280,
          cbOnClick: (event, responseCode) => this.addToCart()
        })
      }
      .margin({ right: 15 })
    }
    .alignItems(HorizontalAlign.Start)
  }

  sizeSelect(checkedIndexes: number[]) {
    if (checkedIndexes.length > 0) {
      prompt.showToast({
        message: "Size Selected " + this.AvailableSizes[checkedIndexes[0]]
      })
    }
  }

  addToCart() {
    prompt.showToast({
      message: "Added to Cart"
    })
  }

  readMoreOpenClose() {
    console.log("read more open close")
    if (this.readMore) {
      this.descriptionHt = "148"
    } else {
      this.descriptionHt = "100%"
    }
    this.readMore = !this.readMore
  }
}