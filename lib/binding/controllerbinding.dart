import 'package:get/get.dart';
import 'package:local_lens/controller/problem.dart';

class ControllerBinding extends Bindings{
  @override
  void dependencies(){
    Get.put(ProblemController());
  }
}