import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission({required Permission permission}) async{
  final status = await permission.status;
  if(status.isGranted){
    return true;
  } else if(status.isDenied){
    if(await permission.request().isGranted){
      return true;
    } else{
      print('Permission denied');
      return false;
    }
  } else{
    print('Permission denied');
    return false;
  }

}