//
//  ViewController.swift
//  GenericDemo
//
//  Created by nguyentienhoang on 11/18/18.
//  Copyright © 2018 nguyentienhoang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let urlStr1 = "https://samples.openweathermap.org/data/3.0/stations?appid=b1b15e88fa797225412429c1c50c122a1"
    let urlStr2 = "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22"
    
    let scrWidth = UIScreen.main.bounds.width
    let scrHeight = UIScreen.main.bounds.height

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttribute()
        setupLayout()
        setupView1Layout()
        setupView2Layout()
    }
    
    private let view1 = UIView()
    private let lbl1 = UILabel()
    private let lbl2 = UILabel()
    private let lbl3 = UILabel()
    
    private let view2 = UIView()
    private let v2lbl1 = UILabel()
    private let v2lbl2 = UILabel()
    private let v2lbl3 = UILabel()

}

//MARK: - request
extension ViewController {
    @objc private func didTap1() {
        getData(urlString: urlStr1) { (model1Data: Model1) in
            self.updateView1(by: model1Data)
        }
    }
    
    @objc private func didTap2() {
        getData(urlString: urlStr2) { (model2Data: Model2) in
            self.updateView2(by: model2Data)
        }
    }
    
    private func getData<T: Codable>(urlString: String, completion:@escaping (T)->()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            guard let data = data else { return }
            do {
                let data = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(data)
                }
            } catch let err {
                print("decode error: ", err)
            }
        }.resume()
    }
    
    private func updateView1(by model: Model1) {
        let id = model.id ?? "no have id"
        let name = model.name ?? "no have name"
        let externalID = model.external_id ?? "no have external ID"
        lbl1.text = "ID: \(id)"
        lbl2.text = "name:  \(name)"
        lbl3.text = "external_id:  \(externalID)"
    }
    
    
    private func updateView2(by model: Model2) {
        let id = model.id ?? 0
        let name = model.name ?? "no have name"
        let cod = model.cod ?? 0
        v2lbl1.text = "ID: \(id)"
        v2lbl2.text = "name: \(name)"
        v2lbl3.text = "cod: \(cod)"
    }
}

//MARK: - layout
extension ViewController {
    private func setupLayout() {
        view.addSubview(view1)
        view.addSubview(view2)
        view1.frame = CGRect(x: 0, y: 20, width: scrWidth, height: scrHeight / 3)
        view2.frame = CGRect(x: 0, y: 50 + 20 + scrHeight / 3, width: scrWidth, height: scrHeight / 3)
    }
    
    private func setupView1Layout() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        view1.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view1.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view1.trailingAnchor),
            stack.topAnchor.constraint(equalTo: view1.topAnchor),
            stack.bottomAnchor.constraint(equalTo: view1.bottomAnchor)
            ])
        
        let btn = UIButton()
        
        lbl1.numberOfLines = 0
        lbl2.numberOfLines = 0
        lbl3.numberOfLines = 0
        btn.backgroundColor = UIColor.orange
        btn.setTitle("Fetch data", for: .normal)
        btn.addTarget(self, action: #selector(didTap1), for: .touchUpInside)
        
        
        stack.addArrangedSubview(lbl1)
        stack.addArrangedSubview(lbl2)
        stack.addArrangedSubview(lbl3)
        stack.addArrangedSubview(btn)
        
        lbl1.text = "ID: "
        lbl2.text = "name: "
        lbl3.text = "external_id: "
    }
    
    private func setupView2Layout() {
        let stack = UIStackView()
        stack.frame = view1.frame
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        view2.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view2.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view2.trailingAnchor),
            stack.topAnchor.constraint(equalTo: view2.topAnchor),
            stack.bottomAnchor.constraint(equalTo: view2.bottomAnchor)
            ])
        let btn = UIButton()
        
        v2lbl1.numberOfLines = 0
        v2lbl2.numberOfLines = 0
        v2lbl3.numberOfLines = 0
        btn.backgroundColor = UIColor.orange
        btn.setTitle("Fetch data", for: .normal)
        btn.addTarget(self, action: #selector(didTap2), for: .touchUpInside)
        
        
        stack.addArrangedSubview(v2lbl1)
        stack.addArrangedSubview(v2lbl2)
        stack.addArrangedSubview(v2lbl3)
        stack.addArrangedSubview(btn)
        
        v2lbl1.text = "ID: "
        v2lbl2.text = "name: "
        v2lbl3.text = "cod: "
    }
    
    private func setupAttribute() {
        view.backgroundColor = .white
        view1.backgroundColor = UIColor.blue.withAlphaComponent(0.1)
        view2.backgroundColor = UIColor.blue.withAlphaComponent(0.1)
    }
}
