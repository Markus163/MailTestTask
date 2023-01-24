//
//  VerificationModel.swift
//  MailTestTask
//
//  Created by Марк Михайлов on 23.01.2023.
//

import Foundation

class VerificationModel {
    
    private let mailsArray = ["@gmail.com", "@yandex.ru", "@mail.ru", "@yahoo.com"]
    
    public var nameMails = String()
    public var filtredMailArray = [String]()
    
    private func filtringMails(text: String) {
        
        var domainMail = String()
        filtredMailArray = []
        
        guard let firstIndex = text.firstIndex(of: "@") else { return }
        let endIndex = text.index(before: text.endIndex)
        let range = text[firstIndex...endIndex]
        domainMail = String(range)
        
        mailsArray.forEach { mail in
            
            if mail.contains(domainMail) {
                if !filtredMailArray.contains(mail) {
                    filtredMailArray.append(mail)
                }
            }
        }
    }
    
    private func deriveNameMail(text: String) {
        guard let atSimbolIndex = text.firstIndex(of: "@") else { return }
        let endIndex = text.index(before: atSimbolIndex)
        let firstIndex = text.startIndex
        let range = text[firstIndex...endIndex]
        nameMails = String(range)
    }
    
    public func getFiltredMail(text: String) {
        filtringMails(text: text)
    }
    
    public func getMailName(text: String) {
        deriveNameMail(text: text)
    }
}
