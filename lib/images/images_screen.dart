import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secand_in_firebase/bloc/bloc/images_bloc.dart';
import 'package:secand_in_firebase/bloc/events/crud_event.dart';
import 'package:secand_in_firebase/bloc/states/crud_state.dart';
import 'package:secand_in_firebase/utills/helpers.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> with Helper {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/upload_images');
              },
              icon: Icon(Icons.broken_image))
        ],
      ),
      body: BlocConsumer<ImagesBloc, CrudState>(
        listenWhen: (previous, current) =>current is CrudProcess && current.processState==ProcessState.delete,
        listener: (context, state) {
         state as CrudProcess;
         showSnackBar(context, state.message,error: !state.success);
        },
        buildWhen: (previous, current) =>
            current is ReadState || current is LoadingState,
        builder: (context, state) {
          print(state);
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ReadState && state.list.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                ),
                // itemCount: controller.images.length,
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    clipBehavior: Clip.antiAlias,
                    child: FutureBuilder<String>(
                      future: state.list[index].getDownloadURL(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState== ConnectionState.waiting){
                          return Center(child: CircularProgressIndicator(),);
                        }
                        else if(snapshot.hasData){
                          return Stack(
                            children: [
                              Image.network(
                                // controller.images[index].imageUrl,
                                snapshot.data!,
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.black45,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                              'to show data and test to show data and test to show data and test',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  overflow: TextOverflow.ellipsis),
                                            )),
                                        IconButton(
                                          onPressed: () {
                                            deleteImage(index: index);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                          padding: EdgeInsets.zero,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        }else{
                          return Center(
                            child: Icon(Icons.image,size: 30,),
                          );
                        }
                      }
                    ),
                  );
                },
              ),
            );
          } else if(state is ReadState && state.list.isEmpty){
            return Center(
                child: Text(
              'NO IMAGES UPLOADED',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            );
          }else{
            return Center(
              child: Text(
                'I don\'t now why this error',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
            );

          }
        },
      ),
    );
  }

   void deleteImage({required int index})  {
    BlocProvider.of<ImagesBloc>(context).add(DeleteEvent(index));
    // ApiResponse apiResponse =
    //     await ImagesGetxController.to.deleteImage(index: index);
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(apiResponse.status
    //           ? 'Delete Image successfully'
    //           : 'Deleted  failed'),
    //       backgroundColor: apiResponse.status? Colors.green:Colors.red,
    //     ),
    //   );
  }
}
