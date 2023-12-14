#[derive(Copy, Drop, Serde)]
struct Fraction {
	sign: bool,
	num: u32,
	den: u32,
}

trait FractionTrait {
	fn toFraction(s: bool, n: u32, d: u32) -> Fraction;
	fn numFraction(f: Fraction) -> u32;
	fn denFraction(f: Fraction) -> u32;
	fn signFraction(f: Fraction) -> bool;
	fn invertFraction(f: Fraction) -> Fraction;
	fn changeSignFraction(f: Fraction) -> Fraction;
	
}


impl FractionImpl of FractionTrait {
	// creates a fraction with said sign and value
	fn toFraction(s: bool, n: u32, d: u32) -> Fraction {
		let fr = Fraction {
			sign: s,
			num: n,
			den: d,
		};
		return fr;
	}

	// fetches the numerator of the fraction
	fn numFraction(f: Fraction) -> u32 {
		return f.num;
	}

	// fetches the denominator of the fraction
	fn denFraction(f: Fraction) -> u32 {
		return f.den;
	}

	// fetches the sign of the fraction, with true being positive and false being negative values
	fn signFraction(f: Fraction) -> bool {
		return f.sign;
	}

	// returns a fraction with the same sign but numerator and denominator reversed
	fn invertFraction(f: Fraction) -> Fraction {
		assert (f.num != 0, 'infinity is not a fraction');
		let fr = Fraction {
			sign: f.sign,
			num: f.den,
			den: f.num,
		};
		return fr;
	}

	// returns a fraction with the same opposite sign but the same numerator and denominator
	fn changeSignFraction(f: Fraction) -> Fraction {
		let fr = Fraction {
			sign: !f.sign,
			num: f.num,
			den: f.den,
		};
		return fr;
	}

	


}





mod tests{
	use super::FractionTrait;

	#[test]
	fn test_convert(){
		let f= FractionTrait::toFraction(true, 7, 2);
		assert (f.num == 7, 'conversion test failed');
	}

	#[test]
	fn test_invert(){
		let f= FractionTrait::toFraction(true, 7, 3);
		let finv = FractionTrait::invertFraction(f);
		assert (finv.num == 3, 'inversion test failed value');
		assert (finv.sign == f.sign, 'inversion test failed sign');
	}

	#[test]
	fn test_sign_change(){
		let f= FractionTrait::toFraction(true, 7, 3);
		let fsc = FractionTrait::changeSignFraction(f);
		assert (fsc.den == 3, 'sign change test failed value');
		assert (fsc.sign != f.sign, 'sign change test failed sign');
	}

	

}

