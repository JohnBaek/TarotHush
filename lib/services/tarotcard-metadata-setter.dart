import 'package:hive/hive.dart';
import 'package:my_app/models/enums/enum-tarot-product.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as pathHelper;
import '../models/hive/hive-tarot-card-metadata.dart';
import '../models/responses/cards/response-tarot-metadata.dart';

/// 타로카드 메타 데이터에 대한 초기화 서비스
class TarotCardMetadataSetter {
  // 메타 데이터 Hive 개체
  late final Box<HiveTarotCardMetadata> _tarotCardMetadataBox;

  /// 생성자
  /// [tarotCardMetadataBox] 메타 데이터 Hive 개체
  TarotCardMetadataSetter({required Box<HiveTarotCardMetadata> tarotCardMetadataBox}) : _tarotCardMetadataBox = tarotCardMetadataBox;

  /// 기본카드 메타 정보를 하이브에 저장 한다.
  Future<void> initMetaAsync() async {
    await initRiderWaitedAsync();
  }

  /// 라이더 웨이티드 타롯에대한 데이터를 초기화 한다.
  Future<void> initRiderWaitedAsync() async {
    // 이미 초기화한 경우
    if(_tarotCardMetadataBox.values.any((element) => element.enumTarotProduct == EnumTarotProduct.riderWaited)) {
      return;
    }
    

    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'The Fool', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'00-TheFool.png') , enumTarotProduct: EnumTarotProduct.riderWaited)); 
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'The Magician', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'01-TheMagician.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'The HighPriestess', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'02-TheHighPriestess.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'The Empress', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'03-TheEmpress.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'The Emperor', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'04-TheEmperor.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'The Hierophant', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'05-TheHierophant.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'The Lovers', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'06-TheLovers.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'The Chariot', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'07-TheChariot.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Strength', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'08-Strength.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'The Hermit', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'09-TheHermit.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Wheel Of Fortune', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'10-WheelOfFortune.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Justice', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'11-Justice.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'The HangedMan', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'12-TheHangedMan.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Death', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'13-Death.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Temperance', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'14-Temperance.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'The Devil', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'15-TheDevil.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'The Tower', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'16-TheTower.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'The Star', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'17-TheStar.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'The Moon', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'18-TheMoon.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'The Sun', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'19-TheSun.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Judgement', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'20-Judgement.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'The World', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'21-TheWorld.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Cups 01', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Cups01.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Cups 02', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Cups02.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Cups 03', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Cups03.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Cups 04', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Cups04.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Cups 05', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Cups05.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Cups 06', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Cups06.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Cups 07', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Cups07.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Cups 08', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Cups08.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Cups 09', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Cups09.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Cups 10', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Cups10.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Cups 11', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Cups11.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Cups 12', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Cups12.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Cups 13', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Cups13.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Cups 14', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Cups14.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Pentacles 01', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Pentacles01.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Pentacles 02', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Pentacles02.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Pentacles 03', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Pentacles03.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Pentacles 04', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Pentacles04.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Pentacles 05', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Pentacles05.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Pentacles 06', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Pentacles06.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Pentacles 07', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Pentacles07.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Pentacles 08', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Pentacles08.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Pentacles 09', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Pentacles09.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Pentacles 10', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Pentacles10.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Pentacles 11', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Pentacles11.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Pentacles 12', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Pentacles12.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Pentacles 13', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Pentacles13.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Pentacles 14', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Pentacles14.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Swords 01', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Swords01.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Swords 02', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Swords02.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Swords 03', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Swords03.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Swords 04', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Swords04.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Swords 05', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Swords05.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Swords 06', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Swords06.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Swords 07', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Swords07.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Swords 08', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Swords08.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Swords 09', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Swords09.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Swords 10', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Swords10.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Swords 11', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Swords11.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Swords 12', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Swords12.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Swords 13', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Swords13.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Swords 14', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Swords14.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Wands 01', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Wands01.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Wands 02', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Wands02.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Wands 03', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Wands03.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Wands 04', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Wands04.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Wands 05', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Wands05.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Wands 06', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Wands06.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Wands 07', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Wands07.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Wands 08', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Wands08.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Wands 09', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Wands09.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Wands 10', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Wands10.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Wands 11', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Wands11.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Wands 12', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Wands12.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Wands 13', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Wands13.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
    await _tarotCardMetadataBox.put(const Uuid().v4(), HiveTarotCardMetadata(title: 'Wands 14', description: '', imagePath: pathHelper.join("assets","images","tarots","rider-waited-classic",'Wands14.png'), enumTarotProduct: EnumTarotProduct.riderWaited));
  }
}