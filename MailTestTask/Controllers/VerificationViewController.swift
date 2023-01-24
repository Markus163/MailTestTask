//
//  ViewController.swift
//  MailTestTask
//
//  Created by Марк Михайлов on 19.01.2023.
//

import UIKit

class VerificationViewController: UIViewController {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let statusLabel = StatusLabel()
    private let mailTextfield = MailTextField()
    private let verificationButton = VerificationButton()
    private let collectionView = MailsCollectionView(frame: .zero,
                                                     collectionViewLayout: UICollectionViewFlowLayout())

    private lazy var stackView = UIStackView(arrangedSubviews: [mailTextfield,
                                                               verificationButton,
                                                               collectionView],
                                        axis: .vertical,
                                        spacing: 20)
    
    private let verificationModel = VerificationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setDelegates()
        setConstraints()
    }

    private func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(statusLabel)
        view.addSubview(stackView)
        verificationButton.addTarget(self,
                                     action: #selector(verificationButtonTapped),
                                     for: .touchUpInside)
    }

    private func setDelegates() {
        collectionView.dataSource = self
        collectionView.selectMailDelegate = self
        mailTextfield.textFieldDelegate = self
    }
    
    @objc private func verificationButtonTapped() {
        print("ButtonTap")
    }
}

//MARK: - SelectProposedMailProtocol
extension VerificationViewController: SelectProposedMailProtocol {
    func selectProposedMail(indexPath: IndexPath) {
        guard let text = mailTextfield.text else { return }
        verificationModel.getMailName(text: text)
        let domainMail = verificationModel.filtredMailArray[indexPath.row]
        let mailFullName = verificationModel.nameMails + domainMail
        mailTextfield.text = mailFullName
        statusLabel.isValid = mailFullName.isValid()
        verificationButton.isValid = mailFullName.isValid()
        verificationModel.filtredMailArray = []
        collectionView.reloadData()
    }
}

//MARK: - ActionsMailTextFieldProtocol

extension VerificationViewController: ActionsMailTextFieldProtocol {
    func typingText(text: String) {
        statusLabel.isValid = text.isValid()
        verificationButton.isValid = text.isValid()
        verificationModel.getFiltredMail(text: text)
        collectionView.reloadData()
    }
    
    func cleanOutTextField() {
        statusLabel.setDeafaultsettings()
        verificationButton.setDeafaultsettings()
        verificationModel.filtredMailArray = []
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDataSource
extension VerificationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        verificationModel.filtredMailArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IdCell.idMailCell.rawValue, for: indexPath) as? MailCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let mailLabelText = verificationModel.filtredMailArray[indexPath.row]
        cell.cellConfigure(mailLabelText: mailLabelText)
        return cell
    }
}

//MARK: - Set Constraints
extension VerificationViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            mailTextfield.heightAnchor.constraint(equalToConstant: 50),
            stackView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 2),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
