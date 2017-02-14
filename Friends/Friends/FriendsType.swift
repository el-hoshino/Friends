//
//  FriendsType.swift
//  Friends
//
//  Created by 史翔新 on 2017/02/14.
//  Copyright © 2017年 crazism.net. All rights reserved.
//

import Foundation

public protocol フレンズタイプ: class, CustomStringConvertible {
	
	var 得意なこと: [String] { get }
	var セリフ: [String] { get }
	var 既知の言葉: [String: (() -> Void)] { get }
	var 勉強した言葉: [String: (() -> Void)] { get set }
	
	func 喋る()
	func 勉強(この言葉を言われたら 言葉: String, これをする 行動: @escaping (() -> Void))
	func メッセージ解読(_ メッセージ: String)
	func 言葉の意味がわからない(_ 内容: String)
	
}

extension フレンズタイプ {
	
	public var 既知の言葉: [String: (() -> Void)] {
		let vocabulary: [String: (() -> Void)] = [
			"喋って": self.喋る
		]
		return vocabulary
	}
	
	public var description: String {
		let prefix = "私は\(type(of: self))、"
		let suffix: String
		switch self.得意なこと.count {
		case 0:
			suffix = "得意なことがまだわからないよー＞＜"
			
		case 1:
			suffix = "\(self.得意なこと[0])が得意だよー！"
			
		default:
			suffix = "\(self.得意なこと[0])や\(self.得意なこと[1])が得意だよー！"
		}
		
		return prefix + suffix
		
	}
	
	public func 喋る() {
		let random = Int(arc4random_uniform(UInt32(self.セリフ.count)))
		print(self.セリフ[random])
	}
	
	public func 勉強(この言葉を言われたら 言葉: String, これをする 行動: @escaping (() -> Void)) {
		self.勉強した言葉[言葉] = 行動
	}
	
	public func メッセージ解読(_ メッセージ: String) {
		if let thingsToDo = self.勉強した言葉[メッセージ] {
			thingsToDo()
			
		} else if let thingsToDo = self.既知の言葉[メッセージ] {
			thingsToDo()
			
		} else {
			self.言葉の意味がわからない(メッセージ)
		}
	}
	
}
