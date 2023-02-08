import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

enum Chain {
  ethereum,
  avalanche,
  binance,
}

extension ChainData on Chain {
  String get name {
    switch (this) {
      case Chain.ethereum:
        return 'Ethereum';
      case Chain.avalanche:
        return 'Avalanche';
      case Chain.binance:
        return 'Binance Smart Chain';
    }
  }

  String get icon {
    switch (this) {
      case Chain.ethereum:
        return 'assets/icons/chains/ethereum.svg';
      case Chain.avalanche:
        return 'assets/icons/chains/avalanche.svg';
      case Chain.binance:
        return 'assets/icons/chains/binance.svg';
    }
  }

  String get symbol {
    switch (this) {
      case Chain.ethereum:
        return 'ETH';
      case Chain.avalanche:
        return 'AVAX';
      case Chain.binance:
        return 'BNB';
    }
  }

  Color get color {
    switch (this) {
      case Chain.ethereum:
        return primaryColor;
      case Chain.avalanche:
        return Color(0xFFE84142);
      case Chain.binance:
        return Color(0xFFFFA113);
    }
  }

  String get shortName {
    switch (this) {
      case Chain.ethereum:
        return 'eth';
      case Chain.avalanche:
        return 'avalanche';
      case Chain.binance:
        return 'bsc';
    }
  }
}
