//
//  NoteVC.swift
//  Kodluyoruz-NoteAppRx
//
//  Created by XCODE on 13.09.2019.
//  Copyright © 2019 XCODE. All rights reserved.
//

import UIKit
import FSCalendar

class NoteVC: UIViewController {
    
    let viewModel = NoteVM()
    
    @IBOutlet weak var calendar: FSCalendar! {
        didSet {
            self.calendar.delegate = self
            self.calendar.dataSource = self
        }
    }
    
    @IBOutlet weak var notesTV: UITableView! {
        didSet {
            self.notesTV.register(UINib(nibName: String(describing: NoteCell.self), bundle: nil), forCellReuseIdentifier: NoteCell.identifier)
            self.notesTV.delegate = self
            self.notesTV.dataSource = self
            self.notesTV.estimatedRowHeight = NoteCell.estimatedRowHeight
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleAddButton(_ sender: UIBarButtonItem) {
        let noteDetailVC = NoteDetailVC(viewModel: NoteDetailVM(selectedDate: viewModel.selectedDate.value))
        self.navigationController?.pushViewController(noteDetailVC, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.getNotesBySelectedDate()
    }
    
    func bindViewModel() {
        self.viewModel.notes.asObservable()
            .subscribe(onNext: { [weak self] notes in
                guard let self = self else { return }
                guard let _ = notes else { return }
                self.notesTV.reloadData()
            })
            .disposed(by: viewModel.disposeBag)
        
        self.viewModel.selectedDate.asObservable()
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] selectedDate in
                guard let self = self else { return }
                self.viewModel.getNotesBySelectedDate()
                self.notesTV.reloadData()
            }).disposed(by: viewModel.disposeBag)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NoteVC: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.viewModel.selectedDate.accept(date.string(dateFormat: .ddMMyyyy))

    }
    
}

extension NoteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = viewModel.notes.value?.count else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.identifier, for: indexPath) as? NoteCell else {
            return UITableViewCell()
        }
        guard let notes = viewModel.notes.value else { return UITableViewCell() }
        let note = notes[indexPath.row]
        cell.configure(title: note.title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let notes = viewModel.notes.value else { return }
            let deletedNote = notes[indexPath.row]
            viewModel.deleteNote(note: deletedNote)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let notes = self.viewModel.notes.value else { return }
        let selectedNote = notes[indexPath.row]
        let noteDetailVC = NoteDetailVC(viewModel: NoteDetailVM(selectedNote: selectedNote, selectedDate: viewModel.selectedDate.value))
        self.navigationController?.pushViewController(noteDetailVC, animated: true)
    }
    
}
