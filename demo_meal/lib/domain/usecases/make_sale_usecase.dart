import '../base_repository/base_meal_repository.dart';

class MakeSaleUseCase{
  BaseMealRepository baseMealRepository;
  MakeSaleUseCase({required this.baseMealRepository});
  execute(List<String> documentIds,String saleValue,String title)
  async {
    await baseMealRepository.makeSale(documentIds, saleValue, title);
  }

}