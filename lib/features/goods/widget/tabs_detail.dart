import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/widgets/expandable_text.dart';
import 'package:flutter/material.dart';

List<Widget> getTabsDetailWidgets() {
  return [
    const Text('상세 설명', style: AppTextStyle.headline),
    SizedBox(height: 8,),
    ExpandableText(
      textWidget: Text(veryLooooooooongText, style: AppTextStyle.bodySmall),
    ),
  ];
}

final String veryLooooooooongText = '''
『미키17』은 봉준호 감독의 첫 영어 SF 영화로, 동명의 소설 『Mickey7』(에드워드 애슈턴 작)을 원작으로 한다. 

주인공 "미키"는 인류가 새로운 행성에 식민지를 건설하기 위해 파견한 소모성 인물, 일명 "디스포서블"이다. 그는 죽음을 반복하며 자신을 복제해 다시 살아나는 존재다.

죽음의 공포가 일상인 미키는 열일곱 번째로 부활한 클론이다. 하지만 어느 날, 살아있는 전 클론인 "미키16"이 여전히 존재함을 알게 되며 혼란에 빠진다.

이는 시스템에 대한 도전, 존재의 의미에 대한 질문, 그리고 '나는 누구인가'라는 철학적 고민으로 이어진다.

주인공 역할은 로버트 패틴슨이 맡았으며, 나오미 애키, 토니 콜렛, 마크 러팔로 등이 출연한다.

봉준호 감독은 이 작품을 통해 「기생충」 이후 할리우드에서의 새로운 도전을 시도하며, 특유의 사회적 메시지를 SF 장르에 녹여냈다.

'디스포서블'이라는 개념은 현대 사회에서 인간의 도구화, 생명 경시 등의 문제를 투영한 설정으로 평가받고 있다.

미키17은 철저한 관리 체계와 생존 전략 속에서도 인간성이 살아남을 수 있는가를 질문한다.

'복제체'와 '원본'의 관계, 인류의 진보와 그 그림자에 대한 탐구가 핵심 테마다.

영화는 2025년 개봉 예정이며, 전 세계적으로 큰 기대를 받고 있다.

이번 작품은 봉 감독이 직접 각본을 쓰고 연출까지 맡은 프로젝트로, 그의 고유한 스타일이 더욱 깊게 배어있다.

SF 장르 특유의 세계관과 철학적 서사를 동시에 즐기고 싶은 관객에게 강력히 추천되는 작품이다.

예고편에서는 우주선, 외계 행성, 기계화된 인간, 충격적인 복제실 등 시각적으로 압도적인 장면들이 펼쳐진다.

이 작품은 단순한 SF 블록버스터가 아니라, 인간 존재와 정체성의 문제를 던지는 깊이 있는 이야기다.

''';
