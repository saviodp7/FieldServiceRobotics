import os
from PIL import Image

def crop_image(input_image_path, output_image_path, left, top, right, bottom):
    """
    Crop an image with the specified dimensions.

    :param input_image_path: str, path to the input image
    :param output_image_path: str, path to save the cropped image
    :param left: int, number of pixels to remove from the left
    :param top: int, number of pixels to remove from the top
    :param right: int, number of pixels to remove from the right
    :param bottom: int, number of pixels to remove from the bottom
    """
    try:
        with Image.open(input_image_path) as img:
            width, height = img.size
            cropped_img = img.crop((left, top, width - right, height - bottom))
            cropped_img.save(output_image_path)
            print(f"Image cropped and saved to {output_image_path}")
    except Exception as e:
        print(f"An error occurred while processing {input_image_path}: {e}")

def crop_images_in_folder(input_folder, output_folder, left, top, right, bottom):
    """
    Crop all images in a specified folder and save them to another folder.

    :param input_folder: str, path to the folder containing images to crop
    :param output_folder: str, path to the folder to save cropped images
    :param left: int, number of pixels to remove from the left
    :param top: int, number of pixels to remove from the top
    :param right: int, number of pixels to remove from the right
    :param bottom: int, number of pixels to remove from the bottom
    """
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    for filename in os.listdir(input_folder):
        if filename.lower().endswith(('.png', '.jpg', '.jpeg', '.bmp', '.gif')):
            input_image_path = os.path.join(input_folder, filename)
            output_image_path = os.path.join(output_folder, filename)
            crop_image(input_image_path, output_image_path, left, top, right, bottom)

# Esempio di utilizzo
input_folder = '.'
output_folder = os.path.join(input_folder, 'crop')
left, top, right, bottom = 130, 30, 110, 60  # Specifica i bordi da rimuovere in pixel

crop_images_in_folder(input_folder, output_folder, left, top, right, bottom)
