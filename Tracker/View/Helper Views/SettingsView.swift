import SwiftUI
import Firebase

struct HomeScreenView: View {
    @AppStorage("uid") var userID = ""
    @SceneStorage("isActive") private var isActive = false
    
    func logOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            userID = ""
            isActive = true
        } catch let signOutError as NSError {
            print("Error signing out")
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Button("Log out") {
                    logOut()
                }
            }
            .navigationTitle("Settings")
        }
        .onChange(of: ScenePhase.active) { phase in
            if phase == .active && isActive {
                isActive = false
            }
        }
        .background(
            NavigationLink(
                destination: LoginView()
                    .navigationBarBackButtonHidden(true),
                isActive: $isActive,
                label: EmptyView.init
            )
        )
    }
}
