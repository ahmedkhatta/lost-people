import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/post.dart';
import 'package:geolocator/geolocator.dart';
import '../providers/posts.dart';

class EditPersonScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditPersonScreen> {
  static String _imageUrl;
  final _dayLostFocusNode = FocusNode();
  final _descruptionFocusNode = FocusNode();
  final _locationFocusNode = FocusNode();
  final _facebockFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editProduct = Post(
      id: null,
      name: '',
      description: '',
      imageUrl: _imageUrl,
      dayLost: '',
      location: '',
      facebock: '',

  );
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updatImageUrl);
    super.initState();
  }

  var _isInit = true;
  var _isloading = false;
  var _initValues = {
    'id': "",
    'name': "",
    'description': "",
    'imageUrl': "",
    'dayLost': "",
    'location': "",
    'facebock': "",

  };
  @override
  void didChangeDependencies() {
    if (_isInit) {
      final prouductId = ModalRoute.of(context).settings.arguments as String;
      if (prouductId != null) {
        _editProduct =
            Provider.of<Posts>(context, listen: false).findById(prouductId);
        _initValues = {
          'name': _editProduct.name,
          'description': _editProduct.description,
          'location': _editProduct.location,
          'facebock': _editProduct.facebock,
          'imageUrl': _imageUrl,
          'dayLost': _editProduct.dayLost,

        };
        _imageUrl = _editProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updatImageUrl);
    _dayLostFocusNode.dispose();
    _locationFocusNode.dispose();

    _descruptionFocusNode.dispose();
    _facebockFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();

    super.dispose();
  }

  void _updatImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrl.startsWith('http') && !_imageUrl.startsWith('https'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _imageUrl = await uploadPost(_image);
    _form.currentState.save();
    setState(() {
      _isloading = true;
    });

    if (_editProduct.id != null) {
      Provider.of<Posts>(context, listen: false)
          .updatePerson(_editProduct.id, _editProduct);
    } else {
      try {
        await Provider.of<Posts>(context, listen: false)
            .addPerson(_editProduct);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text(' An Error  occurred !'),
                  content: Text('something went wrong .'),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text('Ok'))
                  ],
                ));

      }
      setState(() {
        _isloading = false;
      });
      Navigator.of(context).pop();
    }
    //Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("اضافة بيانات شخص مفقود"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Form(
                  key: _form,
                  child: ListView(
                    children: <Widget>[
                      TextFormField(
                        initialValue: _initValues['name'],
                        decoration: InputDecoration(labelText: 'الاسم'),
                        textDirection: TextDirection.rtl,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_dayLostFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'من فضلك أدخل الاسم';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _editProduct = Post(
                            name: value,
                            location: _editProduct.location,
                            description: _editProduct.description,
                            imageUrl: _editProduct.imageUrl,
                            dayLost: _editProduct.dayLost,
                            facebock: _editProduct.facebock,
                            id: _editProduct.id,

                            isFavorite: _editProduct.isFavorite,
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['dayLost'],
                        decoration:
                            InputDecoration(labelText: 'يوم فقدان الشخص '),
                        textInputAction: TextInputAction.next,
                        textDirection: TextDirection.rtl,
                        focusNode: _dayLostFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_locationFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'من فضلك أدخل يوم فقدان الشخص ';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _editProduct = Post(
                            name: _editProduct.name,
                            dayLost: value,
                            location: _editProduct.location,
                            description: _editProduct.description,
                            facebock: _editProduct.facebock,
                            imageUrl: _editProduct.imageUrl,
                            id: _editProduct.id,
                            isFavorite: _editProduct.isFavorite,
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['location'],
                        decoration: InputDecoration(
                          labelText: 'المكان    ',
                        ),
                        textInputAction: TextInputAction.next,
                        textDirection: TextDirection.rtl,
                        focusNode: _locationFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descruptionFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'من فضلك ادخل  مكان الشخص';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _editProduct = Post(
                            name: _editProduct.name,
                            dayLost: _editProduct.dayLost,
                            location: value,
                            description: _editProduct.description,
                            imageUrl: _editProduct.imageUrl,
                            facebock: _editProduct.facebock,
                            id: _editProduct.id,
                            isFavorite: _editProduct.isFavorite,
                          );
                        },
                      ),

                    RaisedButton(
                          onPressed: () async {
                            Position position = await Geolocator()
                                .getCurrentPosition(
                                    desiredAccuracy: LocationAccuracy.high);
                            print(position.longitude);
                            print(position.latitude);
                          },
                          textColor: Colors.blue,


                            child: Row(
                              children: <Widget>[
                                const Text(
                                    '  مكانك الحالي ',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 20)),
                             IconButton(icon: Icon(Icons.location_on,color: Colors.blue,), onPressed: (){})
                              ],
                            ),

                        ),

                      TextFormField(
                        initialValue: _initValues['description'],
                        decoration:
                            InputDecoration(labelText: 'المزيد من المعلومات '),
                        textInputAction: TextInputAction.next,
                        maxLines: 3,
                        focusNode: _descruptionFocusNode,
                        keyboardType: TextInputType.multiline,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_facebockFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'من فضلك أدخل المزيد من المعلومات عن الشخص .';
                          }
                          if (value.length < 10) {
                            return 'يجب ان يكون المعلومات اكثر من عشرة أحرف';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editProduct = Post(
                            name: _editProduct.name,

                            location: _editProduct.location,
                            imageUrl: _editProduct.imageUrl,
                            dayLost: _editProduct.dayLost,
                            description: value,
                            facebock: _editProduct.facebock,
                            id: _editProduct.id,
                            isFavorite: _editProduct.isFavorite,
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['facebock'],
                        decoration: InputDecoration(labelText: 'لينك الفيس بوك'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.url,
                        textDirection: TextDirection.rtl,
                        focusNode: _facebockFocusNode,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'من فضلك أدخل لينك الفيس بوك';
                          }
                          if (!value.startsWith('http') &&
                              !value.startsWith('https')) {
                            return 'هذا اللينك  غير صحيح ';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _editProduct = Post(
                            name: _editProduct.name,
                            dayLost: _editProduct.dayLost,
                            location: _editProduct.location,
                            description: _editProduct.description,
                            facebock: value,
                            imageUrl: _editProduct.imageUrl,
                            id: _editProduct.id,
                            isFavorite: _editProduct.isFavorite,
                          );
                        },
                      ),

                      GestureDetector(
                        onTap: _androidDialog,
                        child: Container(
                          height: 300,
                          width: 200,
                          color: Colors.blueGrey.shade100,
                          child: _image == null
                              ? Icon(
                                  Icons.add_a_photo,
                                  color: Colors.blue,
                                  size: 130,
                                )
                              : Image(
                                  image: FileImage(
                                    _image,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                      )

                      //   LocationInput(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  File _image;
  _androidDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Add Photo'),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('Take Photo'),
                onPressed: () => _handleImage(ImageSource.camera),
              ),
              SimpleDialogOption(
                child: Text('Choose from Gallery'),
                onPressed: () => _handleImage(ImageSource.gallery),
              ),
              SimpleDialogOption(
                child: Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  _handleImage(ImageSource source) async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: source);
    if (imageFile != null) {
      imageFile = await _cropImage(imageFile);
      setState(() {
        _image = imageFile;
      });
    }
  }

  _cropImage(File imageFile) async {
    File croppedImage = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
    );
    return croppedImage;
  }

  static Future<File> compressImage(String photoId, File image) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    File compressedImageFile = await FlutterImageCompress.compressAndGetFile(
      image.absolute.path,
      '$path/img_$photoId.jpg',
      quality: 70,
    );
    return compressedImageFile;
  }

  static final storageRef =
      FirebaseStorage(storageBucket: 'gs://lost-of-people-4abff.appspot.com')
          .ref();
  static Future<String> uploadPost(File imageFile) async {
    String photoId = Uuid().v4();
    File image = await compressImage(photoId, imageFile);
    StorageUploadTask uploadTask =
        storageRef.child('images/posts/post_$photoId.jpg').putFile(image);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }
}
