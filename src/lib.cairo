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
	fn multiplyFraction(f1: Fraction, f2: Fraction) -> Fraction;
	fn divideFraction(f1: Fraction, f2: Fraction) -> Fraction;
	fn compareFraction(f1: Fraction, f2: Fraction) -> u32;
	fn reduceFraction(f: Fraction) -> Fraction;
	//fn approximateFraction(f: Fraction) -> Fraction;
	
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

	fn multiplyFraction(f1: Fraction, f2: Fraction) -> Fraction {
		let fr = Fraction {
			sign: (f1.sign && f2.sign),
			num: (f1.num * f2.num),
			den: (f1.den * f2.den),
		};
		return fr;
	}

	fn divideFraction(f1: Fraction, f2: Fraction) -> Fraction {
		let f2inv = FractionTrait::invertFraction(f2);
		let fr = FractionTrait::multiplyFraction(f1, f2inv);
		return fr;
	}

	fn compareFraction(f1: Fraction, f2: Fraction) -> u32 {
		if ((f1.num == f2.num) && (f1.num == 0)){
			return 0;
		}
		else {
			if (f1.sign != f2.sign){
				if (f1.sign){
					return 1;
				}
				else {
					return 2;
				}
			}
			else {
				
				if ((f1.num*f2.den) > (f2.num*f1.den)){
					if (f1.sign){
						return 1;
					}
					else {
						return 2;
					}
				}
				else {
					
					if ((f1.num*f2.den) != (f2.num*f1.den)){
						if (f1.sign){
							return 2;
						}
						else {
							return 1;
						}
					}
					else {
						return 0;
					}
					
				}
				
			}
		}
	}

	fn reduceFraction(f: Fraction) -> Fraction {
		let mut a = f.num;
		let mut b = f.den;
		let mut min = 0;
		let mut i = 2;
		let mut gcd = 1;
		if a > b {
			min = b;
		}
		else {
			min = a;
		}
		
		loop{

			if (i > min){
				break;
			}
			
			
			if (a%i == 0) & (b%i == 0){
				gcd = i;
			}

			i += 1;
			
		};
		
		
		let fr = Fraction {
			sign: f.sign,
			num: f.num/gcd,
			den: f.den/gcd,
		};
		fr
	}

	//fn approximateFraction(f: Fraction) -> Fraction {
	//	if (f.num < 10000 && f.den < 10000) {
	//		return f;
	//	}
		
	//	else {
	//		let apprx_num = ((u64.try_into(f.num)) * 10000)/(f.den as u64);
	//		let fr = Fraction {
	//			sign: f.sign,
	//			num: apprx_num.try_into().unwrap(),
	//			den: 10000,
	//		};
	//		return fr;
	//	}
	//	return f;
	//}
	

	


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

	#[test]
	fn test_mul() {
		let f1 = FractionTrait::toFraction(true, 1, 5);
		let f2 = FractionTrait::toFraction(true, 5, 1);
		let f = FractionTrait::multiplyFraction(f1, f2);
		assert (f.num == f.den, 'multiplication test failed');
	}

	#[test]
	fn test_div() {
		let f1 = FractionTrait::toFraction(true, 6, 5);
		let f2 = FractionTrait::toFraction(true, 5, 1);
		let f = FractionTrait::divideFraction(f1, f2);
		assert (f.num == 6, 'division test failed num');
		assert (f.den == 25, 'division test failed denom');
	}

	#[test]
	#[available_gas(1000000)]
	fn test_reduce() {
		let f1 = FractionTrait::toFraction(true, 2, 10);
		let f2 = FractionTrait::reduceFraction(f1);

		assert (f2.num == 1, 'reduction test failed');
		
	}

	#[test]
	#[available_gas(1000000)]
	fn test_approx() {
		//let f = FractionTrait::toFraction(true, 333333, 4444444);
		//let fapprox = FractionTrait::approximateFraction(f);

		//assert (fapprox.num == 749, 'approximation test failed');
		
	}
		

}

