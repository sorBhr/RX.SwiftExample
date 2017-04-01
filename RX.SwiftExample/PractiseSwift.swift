//
//  PractiseSwift.swift
//  RX.SwiftExample
//
//  Created by 白海瑞 on 2017/3/31.
//  Copyright © 2017年 rx.swift. All rights reserved.
//

import UIKit
import RxSwift
class PractiseSwift: NSObject {

    let disposeBag = DisposeBag()
    
    let behaviorSubject = BehaviorSubject(value: "z")
    
    override init (){
     super.init()
    }
    //MARK: 发射距离最新的那个值，如果没有发送的值，则发送默认值代替
    func behaviorSubjectPractise() -> Void {
        behaviorSubject.subscribe { e in
            print("Subscription: 1, event: \(e)")
            }.addDisposableTo(disposeBag)
        
        behaviorSubject.on(.next("a"))
        behaviorSubject.on(.next("b"))
        
        behaviorSubject.subscribe { e in /// 我们可以在这里看到，这个订阅收到了三个数据
            print("Subscription: 2, event: \(e)")
            }.addDisposableTo(disposeBag)
        
        behaviorSubject.on(.next("c"))
        behaviorSubject.on(.next("d"))
        behaviorSubject.on(.completed)
    }
    //MARK: Publish 表示RAC的RACSubject
    func publishPractise() {
        let publishSubject = PublishSubject<String>()
        
        publishSubject.subscribe { e in
            print("Subscription: 1, event: \(e)")
            }.addDisposableTo(disposeBag)
        
        publishSubject.on(.next("a"))
        publishSubject.on(.next("b"))
        
        publishSubject.subscribe { e in /// 我们可以在这里看到，这个订阅只收到了两个数据，只有 "c" 和 "d"
            print("Subscription: 2, event: \(e)")
            }.addDisposableTo(disposeBag)
        
        publishSubject.on(.next("c"))
        publishSubject.on(.next("d"))
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 3) {
            publishSubject.onNext("🐱")
        }


    }
    //MARK: RAC的ReplaySubject  bufferSize :表示接收历史值的最大个数
    func replaySubjectPractise() -> Void {
        let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
        
        replaySubject.subscribe { e in
            print("Subscription: 1, event: \(e)")
            }.addDisposableTo(disposeBag)
        
        replaySubject.on(.next("a"))
        replaySubject.on(.next("b"))
        replaySubject.onNext("E")
        
        replaySubject.subscribe { e in /// 我们可以在这里看到，这个订阅收到了四个数据
            print("Subscription: 2, event: \(e)")
            }.addDisposableTo(disposeBag)
        
        replaySubject.on(.next("c"))
        replaySubject.on(.next("d"))

    }
    //MARK: 相当于 behaviorSubject的封装  自己无法发送dispose 想当于一个无限
    func variablePractise() -> Void {
        let variable = Variable("z")
        variable.asObservable().subscribe { e in
            print("Subscription: 1, event: \(e)")
            }.addDisposableTo(disposeBag)
        variable.value = "a"
        variable.value = "b"
        variable.asObservable().subscribe { e in
            print("Subscription: 1, event: \(e)")
            }.addDisposableTo(disposeBag)
        variable.value = "c"
        variable.value = "d"
        variable.value = "🐱"
//        Observable.of(1, 2, 4)
//            .flatMap { fetch($0) }
//            .subscribe {
//                print($0)
//            }
//            .addDisposableTo(disposeBag)


    }

    //MARK: buffer (个人觉得应该是在5秒是个限定，只要count = 2就会发送,五秒到了自动发送收集的值(为nil，则发送一个空值), dispose的时候会发送当前收集的值 注:如果dispose的时候没有收集到值，则会发送一个空的数组)
    func bufferPractise() -> Void {
//        let sequenceToSum = Observable.of(0, 1, 2, 3, 4, 5)
        let publicSubject = PublishSubject<String>()
        
        publicSubject
            .buffer(timeSpan: 5, count: 2, scheduler: MainScheduler.instance)
            .subscribe {
                print($0)
                print(Date())
            }.addDisposableTo(disposeBag)
        publicSubject.onNext("🐈")
        publicSubject.onNext("🐎")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            publicSubject.onNext("🐱")
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 6) {
            publicSubject.onNext("🐀")
            publicSubject.onCompleted()
           
        }
        
        

    }
    //MARK: 没理解
    func windowPractise() -> Void {
        let sequenceToSum = Observable.of(0, 1, 2, 3, 4, 5)
        sequenceToSum
            .window(timeSpan: 5, count: 2, scheduler: MainScheduler.instance)
            .subscribe {
                print($0)
            }.addDisposableTo(disposeBag)

    }
    //MARK: 仅在过了一段指定的时间还没发射数据时才发射一个数据，换句话说就是 debounce 会抑制发射过快的值。注意这一操作需要指定一个线程,有一个很常见的应用场景，比如点击一个 Button 会请求一下数据，然而总有刁民想去不停的点击，那这个 debounce 就很有用了
    func debouncePractise() -> Void {
        Observable.of(1, 2, 3, 4, 5, 6)
            .debounce(1, scheduler: MainScheduler.instance)
            .subscribe {
                print($0)
            }
            .addDisposableTo(disposeBag)
    }
    //MARK: 指定序列的index 只发送这个指定值
    func elementAtPractise() -> Void {
        Observable.of(1, 2, 3, 4, 5, 6)
            .elementAt(2)
            .subscribe {
                print($0)
            }
            .addDisposableTo(disposeBag)
    }
    //MARK: single 相当于take(1)  不同:当序列发射多于一个值时，就会抛出 RxError.MoreThanOneElement ；当序列没有值发射就结束时， single 会抛出 RxError.NoElements(觉得和contain没什么区别)
    func singlePractise() -> Void {
        Observable.of(1, 2, 3, 4, 5, 6)
            .single()
            .subscribe {
                print($0)
            }
            .addDisposableTo(disposeBag)

    }
    //MARK : 完全不懂 (----)
    func samplePractise() -> Void {
//        Observable<Int>.interval(0.1, scheduler: SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Background))
//            .take(100)
//            .sample(Observable<Int>.interval(1, scheduler: SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Background)))
//            .subscribe {
//                print($0)
//            }
//            .addDisposableTo(disposeBag)
    }
}
