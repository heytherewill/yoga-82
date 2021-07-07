# Yoga-82 dataset evaluation keras implmentation

## Dataset preparation

- Vist this [link](https://sites.google.com/view/yoga-82/home) and fill out the form to download the dataset
- Download images using the `image_fetcher.ps1`.
- Manually clean up the images folder by removing wrongly downloaded ones.
- Run `clean_up_sets.ps1` to update the contents of the train/test splits.
- Use train and test splits provided in the dataset.

## Usage

Use `pip` to install `keras`, `keras_applications`, `sklearn`, `Pillow` and `tensorflow`.
Check `models.py` for different existing models and modified hierarchical models. And modify `train_yoga.py` accordingly.

Train model
`python train_yoga.py`

## Reference
Verma, M., Kumawat, S., Nakashima, Y., & Raman, S. (2020). Yoga-82: a new dataset for fine-grained classification of human poses. In Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition Workshops (pp. 1038-1039).
