//
//  NotificationsManager.swift
//  Test
//
//  Created by John Greenwood on 21.04.2021.
//

import Foundation
import UserNotifications

class NotificationsManager {
    
    static var shared: NotificationsManager = {
        NotificationsManager()
    }()
    
    private init() {}
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    func clearPendding() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    func requestAutorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                //
            }
        }
    }
    
    func createNotifications(for weekday: Int, at time: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Непоминание о практике"
        content.body = "Пора заняться практикой!"
        content.sound = .default
        
        var dt = DateComponents()
        dt.weekday = weekday
        dt.hour = Calendar.current.component(.hour, from: time)
        dt.minute = Calendar.current.component(.minute, from: time)
        dt.timeZone = .current
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dt, repeats: true)
        let request = UNNotificationRequest(identifier: "Practive reminder\(weekday)",
                                            content: content,
                                            trigger: trigger)
        
        notificationCenter.add(request, withCompletionHandler: nil)
    }
}
