import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hash/services/image_upload_request.dart';
import 'package:hash/view/property_upload_filter_page.dart';


class FilesPage extends StatefulWidget {
  const FilesPage({Key? key, required this.files, required this.onOpenedFile})
      : super(key: key);
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;
  @override
  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {

  @override
  Widget build(BuildContext context) {
    int length = images.length-1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Images'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            // Expanded(
            //     child: ElevatedButton(onPressed: (){
            //       if(images.length > 5){
            //         length = 5;
            //       }
            //       for (int i = 0; i <= length; i++){
            //         if(images[i] != null){
            //           uploadmultipleimage(images[i]);
            //         }
            //       }
            //       print(length);},child: Text("upload"),)),
            Expanded(
              child: GridView.builder(
                  padding: const EdgeInsets.all(6),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
                  itemCount: widget.files.length,
                  itemBuilder:(context, index){
                    final file = widget.files[index];
                    return buildFile(file);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFile(PlatformFile file) {
    final kb = file.size/1024;
    final mb = kb/1024;
    final fileSize = mb>= 1? mb.toStringAsFixed(2): kb.toStringAsFixed(2);
    //final extension = file.extension??'none';
    final  img = file.path;


    return InkWell(
      onTap: ()=> widget.onOpenedFile(file),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child:
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.file(File(img!)),
            )),
            SizedBox(height: 8,),
            Text(
              file.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              fileSize,
              style: const TextStyle(
                fontSize: 18,
              ),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
