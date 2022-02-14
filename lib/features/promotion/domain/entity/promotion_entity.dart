enum PROMOTION_TYPE { normal, special }

class PromotionEntity {
  final String name, imageUrl, message, liveFrom, liveUpto;

  PromotionEntity(
      {this.name, this.imageUrl, this.message, this.liveFrom, this.liveUpto});
}
