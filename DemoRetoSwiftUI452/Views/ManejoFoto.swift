//
//  ManejoFoto.swift
//  DemoRetoSwiftUI452
//
//  Created by José Molina on 02/10/26.
//

import SwiftUI

import SwiftUI
import PhotosUI
import UIKit

struct ManejoFoto: View {
    @State private var selectedUIImage: UIImage? //guarda la imagen seleccionada o tomada con cámara
    @State private var showCamera = false //controla si se muestra la cámara
    @State private var photoPickerItem: PhotosPickerItem? //guarda la selección del rollo de fotos
    @State private var uploadStatus: String? //guarda un mensaje como “imagen enviada” o “error”
    
    var body: some View {
        VStack(spacing: 16) {
            // Botones superiores
            HStack(spacing: 12) {
                Button {
                    showCamera = true
                } label: {
                    Label("Cámara", systemImage: "camera.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(!UIImagePickerController.isSourceTypeAvailable(.camera))
                
                PhotosPicker(selection: $photoPickerItem, matching: .images) {
                    Label("Rollo", systemImage: "photo.on.rectangle")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            }
            .padding(.horizontal)
            
            // Botón para enviar al servidor
            Button {
                if let image = selectedUIImage {
                    uploadImage(image)
                }
            } label: {
                Label("Enviar al servidor", systemImage: "paperplane.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(selectedUIImage == nil)
            .padding(.horizontal)
            
            // Estado de la subida
            if let status = uploadStatus {
                Text(status)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            //Spacer() //llena el espacio faltante del VStack
            
            // Preview de la imagen
            Group {
                if let image = selectedUIImage {
                    ScrollView {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(12)
                            .shadow(radius: 4)
                            .padding()
                    }
                    .frame(height: 300)
                } else {
                    ContentUnavailableView(
                        "Sin imagen",
                        systemImage: "photo",
                        description: Text("Elige una foto del rollo o toma una con la cámara.")
                    )
                    .padding()
                }
            }
        }
        .sheet(isPresented: $showCamera) {
            CameraPicker(image: $selectedUIImage)
                .ignoresSafeArea()
        } //presenta en una vista emergente el acceso a la camara del dispositivo
        .onChange(of: photoPickerItem) { _, newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    selectedUIImage = uiImage
                }
            }
        }
    }
    
    /// Función para subir imagen al servidor
    func uploadImage(_ image: UIImage) {
        guard let url = URL(string: "http://localhost:3000/files/upload"),
              let imageData = image.jpegData(compressionQuality: 0.8) //convierte la imagen a jpeg
        else {
            uploadStatus = "Error al preparar la imagen"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Límite del multipart
        /* boundary es un texto único que sirve como separador entre las partes del mensaje. Se anuncia en el encabezado para que el servidor sepa reconocerlo*/
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type") //Se usa multipart/form-data porque el servidor espera recibir la foto como un archivo dentro de un formulario
        
        // Construcción del body
        var body = Data() //body guardará los bytes del mensaje completo: las instrucciones del formulario y la imagen
        body.append("--\(boundary)\r\n".data(using: .utf8)!) //marca el inicio de una parte
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"foto.jpg\"\r\n".data(using: .utf8)!) //file es el nombre del campo que espera el servdior y foto.jpg es el nombre del archivo que se guardará
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!) //tipo de contenido jpg
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!) //cierra la parte y termina el mensaje
        
        // Envío del mensaje multiparte
        URLSession.shared.uploadTask(with: request, from: body) { _, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    uploadStatus = "Error: \(error.localizedDescription)"
                } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                    uploadStatus = "Imagen enviada con éxito ✅"
                } else {
                    uploadStatus = "Fallo en la subida ❌"
                }
            }
        }.resume() //inicio de la tarea
    }
}

/// Envoltura de UIKit para la cámara. Permite abrir la cámara de UIKit desde SwiftUI y guardar la foto tomada en selectedUIImage
/// SwiftUI no tiene una estructura para el manejo de la cámara del dispositivo, entonces debemos usar la de UIKit. Este es el wrapper de
struct CameraPicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        picker.allowsEditing = false
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    //El coordinador recibe los eventos de UIKit y los comunica a SwiftUI
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraPicker
        init(_ parent: CameraPicker) { self.parent = parent }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}


#Preview {
    ManejoFoto()
}

