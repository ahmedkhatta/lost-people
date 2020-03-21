import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../FORM_INPUTS/locations_person.dart';
import '../providers/post.dart';
import 'package:geolocator/geolocator.dart';
import '../providers/posts.dart';

class EditPersonScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditPersonScreen> {
  final _dayLostFocusNode = FocusNode();
  final _descruptionFocusNode = FocusNode();
  final _locationFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editProduct =
  Post(id: null, name: '', description: '', imageUrl: '', dayLost: '',location:'');
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
    'location':"",
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
          'location':_editProduct.location ,
          //  'imageUrl': _editProduct.imageUrl,
          'imageUrl': "",
          'dayLost': _editProduct.dayLost ,
        };
        _imageUrlController.text = _editProduct.imageUrl;
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
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();

    super.dispose();
  }

  void _updatImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) )  {
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
//      } finally {
//        setState(() {
//          _isloading = false;
//        });
//        Navigator.of(context).pop();
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
        title: Text("Edit Person"),
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
              child: Form(
                  key: _form,
                  child: ListView(
                    children: <Widget>[
                      TextFormField(
                        initialValue: _initValues['name'],
                        decoration: InputDecoration(labelText: 'name'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_dayLostFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'plese provide a value.';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _editProduct = Post(
                            name: value,
                            location:_editProduct.location,
                            description: _editProduct.description,
                            imageUrl: _editProduct.imageUrl,
                            dayLost: _editProduct.dayLost,
                            id: _editProduct.id,
                            isFavorite: _editProduct.isFavorite,
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['dayLost'],
                        decoration: InputDecoration(labelText: 'dayLost'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _dayLostFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_locationFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Plese enter a dayLost .';
                          }
                          if (double.tryParse(value) == null) {
                            return 'please enter avalid number.';
                          }
                          if (double.parse(value) <= 0) {
                            return 'please enter a number greater than zero';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editProduct = Post(
                            name: _editProduct.name,
                            dayLost:  value,
                            location:_editProduct.location,
                            description: _editProduct.description,
                            imageUrl: _editProduct.imageUrl,

                            id: _editProduct.id,
                            isFavorite: _editProduct.isFavorite,
                          );
                        },
                      ),
                TextFormField(
                  initialValue: _initValues['location'],
                  decoration: InputDecoration(labelText: 'location'),
                  textInputAction: TextInputAction.next,

                  focusNode: _locationFocusNode,

                  validator: (value) {
                    if (value.isEmpty) {
                      return 'pleas enter  a description .';
                    }
                    if (value.length < 10) {
                      return 'Should be at least 10 characters long .';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editProduct = Post(
                      name: _editProduct.name,
                      dayLost: _editProduct.dayLost,
                      location:value,
                      description: _editProduct.description,
                      imageUrl: _editProduct.imageUrl,
                      id: _editProduct.id,
                      isFavorite: _editProduct.isFavorite,
                    );
                  },
                ),

                      Container(
                       child:  RaisedButton(
                         onPressed: ()async {
                           Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                           print(position.longitude);
                           print(position.latitude);
                         },

                         textColor: Colors.white,
                         padding: const EdgeInsets.all(0.0),
                         child: Container(
                           decoration: const BoxDecoration(
                             gradient: LinearGradient(
                               colors: <Color>[
                                 Color(0xFF0D47A1),
                                 Color(0xFF1976D2),
                                 Color(0xFF42A5F5),
                               ],
                             ),
                           ),
                           padding: const EdgeInsets.all(10.0),
                           child: const Text(
                               'Curent Location',
                               style: TextStyle(fontSize: 20)
                           ),
                         ),
                       ),
                      ),
                      TextFormField(
                        initialValue: _initValues['description'],
                        decoration: InputDecoration(labelText: 'Description'),
                        textInputAction: TextInputAction.next,
                        maxLines: 3,
                        focusNode: _descruptionFocusNode,
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'pleas enter  a description .';
                          }
                          if (value.length < 10) {
                            return 'Should be at least 10 characters long .';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editProduct = Post(
                            name: _editProduct.name,
                            description: value,
                            location:_editProduct.location,
                            imageUrl: _editProduct.imageUrl,
                            dayLost: _editProduct.dayLost,
                            id: _editProduct.id,
                            isFavorite: _editProduct.isFavorite,
                          );
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 100.0,
                            height: 100.0,
                            margin: EdgeInsets.only(top: 8, right: 10.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            child: _imageUrlController.text.isEmpty
                                ? Text('Enter a URL')
                                : FittedBox(
                                    child:
                                        Image.network(_imageUrlController.text),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              // initialValue: _initValues['imageUrl'],
                              decoration:
                                  InputDecoration(labelText: 'Image URL'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageUrlController,
                              focusNode: _imageUrlFocusNode,
                              onFieldSubmitted: (_) {
                                _saveForm();
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'pleas enter  an image URL .';
                                }
                                if (!value.startsWith('http') &&
                                    !value.startsWith('https')) {
                                  return 'pleas enter a valid URL .';
                                }
//
                                return null;
                              },
                              onSaved: (value) {
                                _editProduct = Post(
                                  name: _editProduct.name,
                                  location:_editProduct.location,
                                  description: _editProduct.description,
                                  imageUrl: value,
                                  dayLost: _editProduct.dayLost,
                                  id: _editProduct.id,
                                  isFavorite: _editProduct.isFavorite,
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                   //   LocationInput(),
                    ],
                  ),
              ),
            ),
    );
  }
}
