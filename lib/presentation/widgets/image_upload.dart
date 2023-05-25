import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart'; // Added import for image_cropper
import '../template/template.dart';
import 'caousel_widget.dart';

class PrsmImageUpload extends StatefulWidget {
  Function(List<File>, List<String>) onImageSelected;
  int? maxImages;

  PrsmImageUpload({Key? key, required this.onImageSelected, this.maxImages=3}) : super(key: key);

  @override
  State<PrsmImageUpload> createState() => _PrsmImageUploadState();
}

class _PrsmImageUploadState extends State<PrsmImageUpload> {
  List<File> imageFiles = [];
  List<String> imageFileNames = [];

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
          child: (imageFiles.isNotEmpty)
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
      showAddMoreImage: imageFiles.length < widget.maxImages!,
      onAddImg: _selectImage,
      onRemoveImg: (index) {
        setState(() {
          imageFiles.removeAt(index);
          imageFileNames.removeAt(index);
        });
        logger("ImageFilesCount: ${imageFiles.length}");
        widget.onImageSelected(imageFiles, imageFileNames);
      },
      imageFiles: [...imageFiles],
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
          imageFileNames.add(selectedImage.name);
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
      aspectRatio: const CropAspectRatio(ratioX: 18, ratioY: 8),
      cropStyle: CropStyle.rectangle,
      aspectRatioPresets: [CropAspectRatioPreset.ratio16x9],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: '',
            backgroundColor: isDark(context)
                ? MehonotColorsDark.canvasColor
                : MehonotColorsLight.canvasColor,
            toolbarColor: isDark(context)
                ? MehonotColorsDark.canvasColor
                : MehonotColorsLight.canvasColor,
            toolbarWidgetColor:
            isDark(context) ? ThemeColors.coolgray100 : ThemeColors.blue900,
            activeControlsWidgetColor:
            isDark(context) ? ThemeColors.coolgray100 : ThemeColors.blue900,
            cropFrameColor:
            isDark(context) ? ThemeColors.coolgray100 : ThemeColors.blue900,
            statusBarColor: isDark(context)
                ? MehonotColorsDark.canvasColor
                : MehonotColorsLight.canvasColor,
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
