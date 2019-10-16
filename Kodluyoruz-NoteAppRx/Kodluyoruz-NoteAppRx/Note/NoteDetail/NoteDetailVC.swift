//
//  NoteDetailVC.swift
//  Kodluyoruz-NoteAppRx
//
//  Created by XCODE on 14.09.2019.
//  Copyright © 2019 XCODE. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NoteDetailVC: UIViewController {
    
    var viewModel: NoteDetailVM!
    
    //---------------------------- Outlets ----------------------------//
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    
    //---------------------------- View lifecycle ----------------------------//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    func setUpView() {
        hideKeyboard()
        bindViewModel()
    }
    
    //---------------------------- Init ----------------------------//
    init(viewModel: NoteDetailVM) {
        super.init(nibName: String(describing: NoteDetailVC.self), bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //---------------------------- Actions ----------------------------//
    @IBAction func handleSaveButton(_ sender: Any) {
        guard let title = titleTextField.text else { return }
        guard let detail = detailTextView.text, detailTextView.text != NoteDetailVM.NoteDetailPlaceholder else { return }
        
        if let selectedNote = viewModel.selectedNote.value {
            viewModel.updateNote(note: selectedNote, title: title, detail: detail)
        } else {
            let newNote = Note(id: UUID().uuidString, title: title, detail: detail, date: viewModel.selectedDate)
            viewModel.addNote(note: newNote)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    //---------------------------- Class functions ----------------------------//
    func bindViewModel() {
        self.viewModel.selectedNote.asObservable()
            .subscribe(onNext: { [weak self] selectedNote in
                guard let self = self else { return }
                guard let selectedNote = selectedNote else { return }
                self.titleTextField.text = selectedNote.title
                self.detailTextView.text = selectedNote.detail
                self.saveButton.isEnabled = true
                self.saveButton.alpha = 1.0
                self.detailTextView.textColor = .black
            })
            .disposed(by: viewModel.disposeBag)
        
        
        Observable.combineLatest(self.viewModel.title, self.viewModel.detail).asObservable()
            .subscribe(onNext: { [weak self] (title, detail) in
                guard let self = self else { return }
                guard let title = title, let detail = detail else { return }
                let isInputsValid = !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !detail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                
                self.saveButton.isEnabled = isInputsValid
                
                self.saveButton.alpha = isInputsValid ? 1.0 : 0.5
            }).disposed(by: viewModel.disposeBag)
        
        
    }
    
}

//---------------------------- TextField ----------------------------//
extension NoteDetailVC: UITextViewDelegate, UITextFieldDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == NoteDetailVM.NoteDetailPlaceholder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text != NoteDetailVM.NoteDetailPlaceholder {
            self.viewModel.detail.accept(textView.text)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = NoteDetailVM.NoteDetailPlaceholder
            textView.textColor = .lightGray
        }
        self.viewModel.detail.accept(textView.text)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.viewModel.title.accept(textField.text)
    }
}
