import { ProductItems, ProductItemsModel } from "../model/product"


@Component
export  struct GoodCard{
  @State
  products:ProductItems = new ProductItemsModel({} as ProductItems)
  build() {
    Flex(){

    }
  }
}