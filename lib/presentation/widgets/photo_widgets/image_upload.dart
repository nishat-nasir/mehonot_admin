import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart'; // Added import for image_cropper
import 'package:mehonot_admin/presentation/widgets/photo_widgets/caousel_widget.dart';
import '../../template/template.dart';

class PrsmImageUpload extends StatefulWidget {
  Function(List<File>, List<String>) onImageSelected;
  Function(int) onRemoveNetworkImg;
  final List<String> imageNetUrls;
  int? maxImageCount;

  PrsmImageUpload(
      {Key? key,
      required this.onImageSelected,
      required this.onRemoveNetworkImg,
      required this.imageNetUrls,
      this.maxImageCount = 3})
      : super(key: key);

  @override
  State<PrsmImageUpload> createState() => _PrsmImageUploadState();
}

class _PrsmImageUploadState extends State<PrsmImageUpload> {
  List<File> imageFiles = [];
  List<String> imageFileNames = [];
  List<String> imageUrls = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100.w,
      height: 470.h,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: isDark(context) ? ThemeColors.coolgray800 : ThemeColors.blue100,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: DottedBorder(
        strokeCap: StrokeCap.butt,
        color: ThemeColors.blue500,
        strokeWidth: 3.w,
        dashPattern: const [6, 4],
        padding: EdgeInsets.all(15.w),
        radius: Radius.circular(20.r),
        child: Center(
          heightFactor: 1.5,
          child: (imageFiles.isNotEmpty || widget.imageNetUrls.isNotEmpty)
              ? buildImagesContainer()
              : SpacedColumn(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/png/gallery_icon.png",
                      width: 140.w,
                      height: 140.h,
                    ),
                    PrimaryButton(
                      buttonText: "Upload Image",
                      buttonSize: ButtonSize.M,
                      onPressed: _selectImage,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildImagesContainer() {
    return PrsmCarouselUploadImgWidget(
      showAddMoreImage: imageFiles.length + widget.imageNetUrls.length <
          widget.maxImageCount!,
      onAddImg: _selectImage,
      onRemoveNetworkImg: (index) {
        widget.onRemoveNetworkImg(index);
      },
      onRemoveImg: (index) {
        setState(() {
          imageFiles.removeAt(index);
        });
        logger("ImageFilesCount: ${imageFiles.length}");
      },
      imageFiles: [...imageFiles],
      imageNetworkUrls: [...widget.imageNetUrls],
    );
  }

  Future<void> _selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      CroppedFile? croppedImage = await _cropImage(File(selectedImage.path));

      if (croppedImage != null) {
        setState(() {
          imageFiles.add(File(croppedImage.path));
        });
      }
    }

    widget.onImageSelected(imageFiles, imageFileNames);
  }

  Future<CroppedFile?> _cropImage(File imagePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      aspectRatio: const CropAspectRatio(ratioX: 15, ratioY: 8),
      cropStyle: CropStyle.rectangle,
      aspectRatioPresets: [CropAspectRatioPreset.ratio16x9],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            backgroundColor: isDark(context)
                ? PrsmColorsDark.canvasColor
                : PrsmColorsLight.canvasColor,
            toolbarColor: isDark(context)
                ? PrsmColorsDark.canvasColor
                : PrsmColorsLight.canvasColor,
            toolbarWidgetColor:
                isDark(context) ? ThemeColors.coolgray100 : ThemeColors.blue900,
            activeControlsWidgetColor:
                isDark(context) ? ThemeColors.coolgray100 : ThemeColors.blue900,
            cropFrameColor:
                isDark(context) ? ThemeColors.coolgray100 : ThemeColors.blue900,
            statusBarColor: isDark(context)
                ? PrsmColorsDark.canvasColor
                : PrsmColorsLight.canvasColor,
            lockAspectRatio: true),
        IOSUiSettings(
          title: '',
        ),
        WebUiSettings(
          context: context,
          presentStyle: CropperPresentStyle.dialog,
          boundary: const CroppieBoundary(
            width: 520,
            height: 520,
          ),
          viewPort:
              const CroppieViewPort(width: 480, height: 480, type: 'circle'),
          enableExif: true,
          enableZoom: true,
          showZoomer: true,
        ),
      ],
    );
    if (croppedFile != null) {
      return croppedFile;
    }
    return null;
  }
}

class PrsmCompanyLogoUpload extends StatefulWidget {
  Function(File, String) onImageSelected;

  PrsmCompanyLogoUpload({
    Key? key,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  _PrsmCompanyLogoUploadState createState() => _PrsmCompanyLogoUploadState();
}

class _PrsmCompanyLogoUploadState extends State<PrsmCompanyLogoUpload> {
  File? _image;

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      final croppedImage = await _cropImage(File(selectedImage.path));

      if (croppedImage != null) {
        setState(() {
          _image = File(croppedImage.path);
        });
      }
    }

    widget.onImageSelected(_image!, _image!.path.split('/').last);
  }

  Future<CroppedFile?> _cropImage(File image) async {
    final croppedImage = await ImageCropper().cropImage(
        sourcePath: image.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            statusBarColor: Colors.blue,
            backgroundColor: Colors.white,
          ),
          IOSUiSettings(
            title: 'Crop Image',
          ),
        ]);

    if (croppedImage != null) {
      return croppedImage;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: getImage,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color:
              isDark(context) ? ThemeColors.coolgray800 : ThemeColors.blue100,
          borderRadius: BorderRadius.circular(8.r),
          image: _image != null
              ? DecorationImage(
                  image: FileImage(_image!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: _image == null
            ? const Icon(
                Icons.camera_alt,
                size: 40,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
