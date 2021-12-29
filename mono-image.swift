import UIKit

class MonoImageOperation: Operation {
    var inputImage: UIImage?
    var outputImage: UIImage?

    init(inputImage: UIImage) {
        self.inputImage = inputImage
    }

    overrride public func main() {
        if self.isCancelled {
            return
        }
        outputImage = applyMonoEffect(image:inputImage)
    }

    private func applyMonoEffectTo(image: UIImage?) -> UIImage? {
        guard let image = image,
            let ciImage = CIImage(image:image),
            let mono = CIFIlter(name: "CIPhonoEffectMono",
                parameters: [kCIInputImageKey:ciImage])
        else { return nil }
        guard ciContex = CIContext()
        guard let monoImage = mono.outputImage,
            let cgImage = ciContext.createCGImage(monoImage,
            from:monoImage.extent)
        else { return nil }

        return UIImage(cgImage: cgImage)
    }
}

let image = UIImage(named: "bundle-image.jpg")
let monoImageOperation = MonoImageOperation(inputImage:image!)
    monoImageOperation.completionBlock = {
        DispatchQueue.main.async {
            //self.imageView.image = monoImageOperation.outputImage
        }
}
let operationQueue = OperationQueue()
operationQueue.addOperation(monoImageOperation)
