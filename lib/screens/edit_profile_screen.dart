import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_carbon/blocs/blocs.dart';
import 'package:mobile_carbon/repositories/repositories.dart';

import '../commons/commons.dart';
import '../routes.dart';
import '../widgets/widgets.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument =
        ModalRoute.of(context)!.settings.arguments as AccountArgument;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final repository = RepositoryProvider.of<AuthRepository>(context);

            return AuthBloc(repository);
          },
        ),
      ],
      child: EditProfileContent(
        argument: argument,
      ),
    );
  }
}

class EditProfileContent extends StatefulWidget {
  final AccountArgument? argument;

  const EditProfileContent({
    this.argument,
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfileContent> createState() => _EditProfileContentState();
}

class _EditProfileContentState extends State<EditProfileContent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.argument?.name ?? "";
    emailController.text = widget.argument?.email ?? "";
    telephoneController.text = widget.argument?.phone ?? "";
    addressController.text = widget.argument?.address ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.backgroundLight,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Ubah Profil",
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontSize: 18.0,
                color: ColorPalettes.dark,
                fontWeight: FontWeight.w700,
              ),
        ),
        backgroundColor: ColorPalettes.backgroundLight,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.chevron_left_rounded,
            color: ColorPalettes.dark,
          ),
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: BlocListener<AuthBloc, AuthState>(
          listener: _actionBlocListener,
          child: ListView(
            children: [
              TextFieldInput(
                labelText: "Nama",
                hintText: "Masukkan nama",
                maxLength: null,
                controller: nameController,
                callback: (value) => print(
                  "==> name: $value",
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextFieldInput(
                labelText: "Email",
                hintText: "Masukkan email",
                maxLength: null,
                controller: emailController,
                callback: (value) => print(
                  "==> email: $value",
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextFieldInput(
                labelText: "Nomor Telepon",
                hintText: "Masukkan nomor telepon",
                maxLength: null,
                controller: telephoneController,
                keyboardType: TextInputType.number,
                callback: (value) => print(
                  "==> telephone: $value",
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextFieldInput(
                labelText: "Alamat",
                hintText: "Masukkan alamat",
                maxLength: null,
                minLines: 5,
                controller: addressController,
                callback: (value) => print(
                  "==> address: $value",
                ),
              ),
              const SizedBox(
                height: 70.0,
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(
                  left: 15.0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: CarbonRoundedButton(
                        label: "Batal",
                        labelColor: ColorPalettes.dark,
                        backgroundColor: ColorPalettes.backgroundLight,
                        borderColor: ColorPalettes.line,
                        action: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    Expanded(
                      child: CarbonRoundedButton(
                        label: "Simpan",
                        backgroundColor: ColorPalettes.primary,
                        borderColor: ColorPalettes.primary,
                        action: () => _showConfirmation(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showConfirmation(BuildContext currentContext) async {
    final data = await showModalBottomSheet(
      context: currentContext,
      isScrollControlled: true,
      shape: defaultBottomSheetShape,
      builder: (context) => EditProfileBottomSheet(
        label: "Ubah Profil",
        caption:
            "Apakah Anda ingin mengubah profil pengguna? Profil pengguna yang telah "
            "diubah tidak dapat dikembalikan lagi.",
        negativeCallback: () => Navigator.pop(context),
        positiveLabel: "Ubah",
        positiveCallback: () {
          Navigator.pop(context);
          // Navigator.pop(context);
          BlocProvider.of<AuthBloc>(currentContext).add(
            StoreUpdateAccount(
              nameController.text,
              emailController.text,
              telephoneController.text,
              addressController.text,
              null,
            ),
          );
        },
      ),
    );

    if (data != null) {
      // do something
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    telephoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void _actionBlocListener(
    BuildContext context,
    AuthState state,
  ) {
    if (state is StoreAccountUpdateSuccess) {
      // close progress dialog
      Navigator.of(context).pop();

      // navigate to other page
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.profile,
        (route) => false,
      );
    } else if (state is StoreAccountUpdateError) {
      // close progress dialog
      Navigator.of(context).pop();

      ToastUtil.error(
        context,
        state.errorResponse.errors ??
            "Terjadi kesalahan, silahkan coba lagi nanti.",
      );
    } else if (state is StoreAccountUpdateLoading) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => const TransparentLoadingDialog(),
      );
    }
  }
}
