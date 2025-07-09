import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';

class KpostalAddressSearchWidget extends StatefulWidget {
  const KpostalAddressSearchWidget({super.key});

  @override
  State<KpostalAddressSearchWidget> createState() =>
      _KpostalAddressSearchWidgetState();
}

class _KpostalAddressSearchWidgetState
    extends State<KpostalAddressSearchWidget> {
  String? postCode;
  String? address;
  String? latitude;
  String? longitude;
  String? kakaoLatitude;
  String? kakaoLongitude;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (__) => KpostalView(
                      useLocalServer: true,
                      localPort: 1024,
                      callback: (Kpostal result) {
                        setState(() {
                          postCode = result.postCode;
                          address = result.address;
                          latitude = result.latitude.toString();
                          longitude = result.longitude.toString();

                        });
                      },
                    ),
              ),
            );
          },
          child: Text(
            "s", style: AppTextStyle.section,
          ),
        ),
        Container(
          padding: EdgeInsets.all(40.0),
          child: Column(
            children: [
              Text('postCode',
                  style: AppTextStyle.body),
              Text('result: ${this.postCode}', style: AppTextStyle.bodySmall,),
              Text('address',
                  style: AppTextStyle.body),
              Text('result: ${this.address}', style: AppTextStyle.bodySmall,),
              Text('LatLng', style: AppTextStyle.body),
              Text(
                  'latitude: ${this.latitude} / longitude: ${this.longitude}',style: AppTextStyle.bodySmall,),
              Text('through KAKAO Geocoder',
                  style: AppTextStyle.body),

            ],
          ),
        ),
      ],
    );
  }
}
