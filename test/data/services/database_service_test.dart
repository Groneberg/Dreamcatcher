import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:dreamcatcher/src/data/services/database_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:objectbox/objectbox.dart';

class MockStore extends Mock implements Store {}
class MockBox<T> extends Mock implements Box<T> {}
class MockQueryBuilder<T> extends Mock implements QueryBuilder<T> {}
class MockQuery<T> extends Mock implements Query<T> {}

class FakeCondition<T> extends Fake implements Condition<T> {}

void main() {
  late MockStore mockStore;
  late MockBox<Dream> mockBox;
  late MockQueryBuilder<Dream> mockQueryBuilder;
  late MockQuery<Dream> mockQuery;
  late DatabaseService databaseService;

  setUpAll(() {
    registerFallbackValue(FakeCondition<Dream>());
  });

  setUp(() {
    mockStore = MockStore();
    mockBox = MockBox<Dream>();
    mockQueryBuilder = MockQueryBuilder<Dream>();
    mockQuery = MockQuery<Dream>();

    when(() => mockStore.box<Dream>()).thenReturn(mockBox);
    databaseService = DatabaseService(mockStore);
  });

  tearDown(() {
    reset(mockStore);
    reset(mockBox);
    reset(mockQuery);
  });

  group('DatabaseService', () {
    test('saveDream calls box.put with the correct dream', () async {
      final dream = Dream(
        id: 0,
        title: 'Test Dream',
        content: 'Content',
        date: DateTime(2026, 6, 30),
        clarityScore: 4,
        tags: ['lucid'],
      );

      when(() => mockBox.put(dream)).thenReturn(dream.id);

      await databaseService.saveDream(dream);

      verify(() => mockBox.put(dream)).called(1);
    });

    test('deleteDream calls box.remove with the correct id', () async {
      when(() => mockBox.remove(1)).thenReturn(true);

      await databaseService.deleteDream(1);

      verify(() => mockBox.remove(1)).called(1);
    });

    test('listenToDreamById emits the current dream from the query stream', () async {
      final dream = Dream(
        id: 1,
        title: 'Stream Dream',
        content: 'Stream content',
        date: DateTime(2026, 6, 30),
        clarityScore: 5,
        tags: ['sleep'],
      );

      when(() => mockBox.query(any())).thenReturn(mockQueryBuilder);
      when(() => mockQueryBuilder.watch(triggerImmediately: true)).thenAnswer(
        (_) => Stream.value(mockQuery),
      );
      when(() => mockQuery.findFirst()).thenReturn(dream);

      final stream = databaseService.listenToDreamById(1);

      expect(stream, emits(dream));

      verify(() => mockBox.query(any())).called(1);
      verify(() => mockQueryBuilder.watch(triggerImmediately: true)).called(1);
    });
  });
}
