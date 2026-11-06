import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/data_bundles/domain/entities/data_purchase_entity.dart';

/// The shape production actually stores.
///
/// Measured against prod on 2026-11-06: `provider_id` is EMPTY on all 61 data
/// purchases ever made, and the plan id lives in `metadata.variation_id` with
/// `vtpass_service_id` carrying the catalogue network code verbatim.
DataPurchaseEntity _row({
  String dataPlan = '',
  String phone = '07067334850',
  Map<String, dynamic>? meta,
}) =>
    DataPurchaseEntity(
      id: 'ba6fb6df',
      userId: 'u1',
      accountId: 'a1',
      reference: 'DATA-1793975497-86c2d8e8',
      amount: 55,
      status: 'completed',
      phoneNumber: phone,
      dataPlan: dataPlan,
      newBalance: 0,
      commissionEarned: 0,
      providerReference: 'DATA-1793975497-86c2d8e8',
      createdAt: '2026-11-06T14:31:38Z',
      billType: 'data',
      metadata: meta == null ? '' : jsonEncode(meta),
    );

void main() {
  group('planVariationId — what Repeat Purchase repeats', () {
    test('falls back to metadata when provider_id is empty, which is always',
        () {
      final p = _row(meta: {
        'variation_id': 'mtn-social-150mb',
        'plan_name': 'mtn-social-150mb',
      });
      expect(p.planVariationId, 'mtn-social-150mb');
    });

    test('prefers the column so a backend that starts populating it wins', () {
      final p = _row(
        dataPlan: 'mtn_1gb_30d',
        meta: {'variation_id': 'mtn-social-150mb'},
      );
      expect(p.planVariationId, 'mtn_1gb_30d');
    });

    test('plan_name is accepted when variation_id is absent', () {
      expect(_row(meta: {'plan_name': 'glo-2gb'}).planVariationId, 'glo-2gb');
    });

    test('empty when the row carries neither — the repeat must not guess', () {
      expect(_row().planVariationId, '');
      expect(_row(meta: {'network': 'mtn'}).planVariationId, '');
    });
  });

  group('dataCatalogueNetwork — the only spelling getDataPlans accepts', () {
    test('vtpass_service_id is the catalogue code verbatim', () {
      final p = _row(meta: {'vtpass_service_id': 'mtn-data', 'network': 'mtn'});
      expect(p.dataCatalogueNetwork, 'mtn-data');
    });

    test('the bare network ticker is suffixed, never passed through raw', () {
      // `mtn` is what the NCC prefix map yields and what the old repeat sent
      // straight to the catalogue, which answers for `mtn-data` only.
      expect(_row(meta: {'network': 'mtn'}).dataCatalogueNetwork, 'mtn-data');
      expect(_row(meta: {'network': 'MTN'}).dataCatalogueNetwork, 'mtn-data');
    });

    test('9mobile maps to etisalat, the key the catalogue actually uses', () {
      expect(_row(meta: {'network': '9mobile'}).dataCatalogueNetwork,
          'etisalat-data');
    });

    test('falls back to the phone prefix when metadata says nothing', () {
      // 0706 is an MTN prefix.
      expect(_row(phone: '07067334850').dataCatalogueNetwork, 'mtn-data');
    });

    test('empty for an unallocated prefix with no metadata — say so, do not '
        'navigate nowhere', () {
      expect(_row(phone: '0100000000').dataCatalogueNetwork, '');
    });

    test('a plan-id-derived carrier still produces the catalogue code', () {
      // networkCode yields `MTN` from the plan-id prefix; it must not reach
      // getDataPlans in that spelling.
      final p = _row(dataPlan: 'MTN_1GB');
      expect(p.networkCode, 'MTN');
      expect(p.dataCatalogueNetwork, 'mtn-data');
    });
  });
}
